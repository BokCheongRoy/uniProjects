<?php
/** @author All members */

require_once __DIR__ . '/../config/bootstrap.php';
require_once __DIR__ . '/../Model/ReviewFacade.php';
require_once __DIR__ . '/../Model/Review.php';
require_once __DIR__ . '/../Controller/BookController.php';
require_once __DIR__ . '/../Controller/WishlistController.php';
require_once __DIR__ . '/../Model/Wishlist.php';

use BookShopManagementSystem\Model\ReviewFacade;
use BookShopManagementSystem\Controller\BookController;
use BookShopManagementSystem\Controller\WishlistController;
use BookShopManagementSystem\Model\Wishlist;
use BookShopManagementSystem\Model\Review;

if (isset($_GET['bookId'])) {
    $bookId = $_GET['bookId'];

    // Get book details
    $bookController = new BookController();
    $book = $bookController->getBookById($bookId);

    $reviewModel = new Review();
    $reviewFacade = new ReviewFacade($reviewModel);
    $ratingFilter = isset($_GET['ratingFilter']) && $_GET['ratingFilter'] !== '' ? (int) $_GET['ratingFilter'] : null;

    $sortDate = isset($_GET['sortDate']) ? $_GET['sortDate'] : 'desc';
    $reviewData = $reviewFacade->getReviewsAndRating($bookId, $ratingFilter, $sortDate);
    $reviews = $reviewData['reviews'];
    $overallRating = $reviewData['overallRating'] ?? 0.0;

    // Handle wishlist logic
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    } $custId = $_SESSION['custId'] ?? null;
    $isInWishlist = $custId ? Wishlist::isBookInWishlist($custId, $bookId) : false;

    if ($book) {
        $stockQuantity = $book->stock; // Fetch the stock quantity
        ?>
        <!DOCTYPE html>
        <html>
            <head>
                <meta charset="UTF-8">
                <title>Book Details</title>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
                <style>
                    .quantity-input {
                        display: flex;
                        align-items: center;
                        gap: 10px;
                    }
                    .quantity-input input {
                        text-align: center;
                        width: 50px;
                    }
                    .quantity-input button {
                        padding: 5px;
                    }
                    .review-list {
                        margin-top: 20px;
                    }

                    .review-item {
                        padding: 20px;
                        margin-bottom: 20px;
                        background-color: #f9f9f9;
                        border: 1px solid #eaeaea;
                        border-radius: 8px;
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                    }

                    .review-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 10px;
                    }

                    .review-rating {
                        display: flex;
                        align-items: center;
                    }

                    .fa-star {
                        color: #ddd;
                    }

                    .fa-star.checked {
                        color: #FFD700;
                    }

                    .review-body {
                        margin-top: 10px;
                        margin-bottom: 10px;
                    }
                    .review-image img {
                        max-width: 200px;
                        height: auto;
                        border-radius: 8px;
                        margin-bottom: 10px;
                    }
                    .review-date {
                        color: #888;
                        font-size: 0.9rem;
                    }

                    .staff-comment {
                        background-color: #f1f8e9;
                        padding: 15px;
                        margin-top: 15px;
                        border-left: 4px solid #8bc34a;
                    }

                    hr {
                        border-top: 1px solid #eaeaea;
                        margin: 20px 0;
                    }

                    .filter-container {
                        display: flex;
                        align-items: center;
                        justify-content: flex-start;
                        gap: 15px;
                        margin-bottom: 20px;
                    }

                    .filter-container select {
                        width: 150px;
                    }

                    .btn-primary {
                        background-color: #007bff;
                        border-color: #007bff;
                        padding: 6px 12px;
                    }

                    .wishlist-btn {
                        border: none;
                        background: none;
                        cursor: pointer;
                    }
                </style>
                <script>
                    let stockQuantity = <?php echo json_encode($stockQuantity); ?>; // Pass stock quantity to JavaScript

                    function increment() {
                        let quantityInput = document.getElementById('quantity');
                        let currentValue = parseInt(quantityInput.value);
                        if (currentValue < stockQuantity) { // Check against stock quantity
                            quantityInput.value = currentValue + 1;
                        }
                    }

                    function decrement() {
                        let quantityInput = document.getElementById('quantity');
                        let currentValue = parseInt(quantityInput.value);
                        if (currentValue > 1) {
                            quantityInput.value = currentValue - 1;
                        }
                    }
                </script>
            </head>
            <body>
                <?php include "Header.php"; ?>

                <section class="bg-light">
                    <div class="container pb-5">
                        <div class="row">
                            <div class="col-lg-5 mt-5">
                                <div class="card mb-3">
                                    <img class="card-img img-fluid" src="<?php echo htmlspecialchars($book->image); ?>" alt="Book Cover" id="product-detail">
                                </div>
                            </div>

                            <div class="col-lg-7 mt-5">
                                <div class="card">
                                    <div> 
                                        <form action="../Controller/WishlistController.php" method="POST" style="margin-top: 10px;">
                                            <input type="hidden" name="bookId" value="<?php echo htmlspecialchars($book->bookId); ?>">
                                            <input type="hidden" name="action" value="<?php echo $isInWishlist ? 'removeItemDetails' : 'addItem'; ?>">
                                            <button type="submit" class="wishlist-btn" style="float: right;">
                                                <?php if ($isInWishlist): ?>
                                                    <i class="fa-solid fa-heart" style="color: red;"></i>
                                                <?php else: ?>
                                                    <i class="fa-regular fa-heart"></i>
                                                <?php endif; ?>
                                            </button>
                                        </form></div>
                                    <!-- Cart Form -->
                                    <form action="../Controller/CartController.php" method="POST">
                                        <div class="card-body">
                                            <h1 class="h2">
                                                <b><?php echo htmlspecialchars($book->bookName); ?></b> 

                                                (<?php echo htmlspecialchars($book->bookId); ?>)
                                            </h1>
                                            <p class="h3 py-2">RM<?php echo htmlspecialchars($book->price); ?></p>

                                            <h6>Description:</h6>
                                            <p><?php echo htmlspecialchars($book->description); ?></p>
                                            <h6>Author: </h6>
                                            <p><?php echo htmlspecialchars($book->author); ?></p>
                                            <h6>Category: </h6>
                                            <p><?php echo htmlspecialchars($book->category); ?></p>
                                            <h6>Stock: </h6>
                                            <p><?php echo htmlspecialchars($book->stock); ?></p>

                                            <!-- Quantity Input with Increment and Decrement -->
                                            <div class="row pb-3">
                                                <div class="col-md-4">
                                                    <label for="quantity">Quantity</label>
                                                    <div class="input-group">
                                                        <button type="button" class="btn btn-outline-secondary" onclick="decrement()">-</button>
                                                        <input type="text" name="quantity" id="quantity" class="form-control text-center" value="1" required>
                                                        <button type="button" class="btn btn-outline-secondary" onclick="increment()">+</button>
                                                    </div>
                                                </div>
                                            </div>

                                            <input type="hidden" name="bookId" value="<?php echo htmlspecialchars($book->bookId); ?>">
                                            <input type="hidden" name="action" value="addCart">

                                            <div class="row pb-3">
                                                <div class="col d-grid">
                                                    <input type="submit" class="btn btn-success btn-lg" value="Add to Cart">
                                                </div>
                                            </div>
                                        </div>
                                    </form>


                                </div>
                            </div>
                        </div>

                        <!-- Ratings, Reviews, and Comments Section -->
                        <div class="card mt-4">
                            <div class="card-body">
                                <h3>Overall Rating<span class="fa fa-star checked"></span>: <?php echo number_format($overallRating, 1); ?> / 5</h3>

                                <h4>User Reviews</h4>
                                <form method="GET" action="ViewBookDetails.php">
                                    <div class="filter-container">
                                        <input type="hidden" name="bookId" value="<?php echo htmlspecialchars($bookId); ?>">

                                        <!-- Filter by Rating -->
                                        <div class="form-group">
                                            <label for="ratingFilter">Filter by Rating:</label>
                                            <select name="ratingFilter" id="ratingFilter" class="form-control">
                                                <option value="">All Ratings</option>
                                                <option value="1" <?php echo isset($_GET['ratingFilter']) && $_GET['ratingFilter'] == '1' ? 'selected' : ''; ?>>1 Star</option>
                                                <option value="2" <?php echo isset($_GET['ratingFilter']) && $_GET['ratingFilter'] == '2' ? 'selected' : ''; ?>>2 Stars</option>
                                                <option value="3" <?php echo isset($_GET['ratingFilter']) && $_GET['ratingFilter'] == '3' ? 'selected' : ''; ?>>3 Stars</option>
                                                <option value="4" <?php echo isset($_GET['ratingFilter']) && $_GET['ratingFilter'] == '4' ? 'selected' : ''; ?>>4 Stars</option>
                                                <option value="5" <?php echo isset($_GET['ratingFilter']) && $_GET['ratingFilter'] == '5' ? 'selected' : ''; ?>>5 Stars</option>
                                            </select>
                                        </div>

                                        <!-- Sort by Date -->
                                        <div class="form-group">
                                            <label for="sortDate">Sort by Date:</label>
                                            <select name="sortDate" id="sortDate" class="form-control">
                                                <option value="desc" <?php echo isset($_GET['sortDate']) && $_GET['sortDate'] == 'desc' ? 'selected' : ''; ?>>Newest First</option>
                                                <option value="asc" <?php echo isset($_GET['sortDate']) && $_GET['sortDate'] == 'asc' ? 'selected' : ''; ?>>Oldest First</option>
                                            </select>
                                        </div>

                                        <button type="submit" class="btn btn-primary">Apply Filter</button>
                                    </div>
                                </form>

                                <!-- Reviews List -->
                                <?php if ($reviews->isNotEmpty()): ?>
                                    <div class="review-list">
                                        <?php foreach ($reviews as $review): ?>
                                            <div class="review-item">
                                                <div class="review-header">
                                                    <span class="reviewer-name"><strong>Anonymous Customer: </strong></span>
                                                    <span class="review-rating">
                                                        <!-- Display star rating -->
                                                        <?php for ($i = 1; $i <= 5; $i++): ?>
                                                            <span class="fa fa-star <?php echo $i <= $review->rating ? 'checked' : ''; ?>"></span>
                                                        <?php endfor; ?>
                                                        (<?php echo htmlspecialchars($review->rating); ?> / 5)
                                                    </span>
                                                </div>

                                                <div class="review-date">
                                                    <small><em>Reviewed on: <?php echo date('d F, Y', strtotime($review->review_date)); ?></em></small>
                                                </div>
                                                <br>
                                                <div class="review-image">
                                                    <img class="card-img img-fluid" src="<?php echo '../' . $review->photo; ?>" alt="Review Photo" id="photo-" >
                                                </div>
                                                <div class="review-body">
                                                    <p class="review-text"><?php echo htmlspecialchars($review->review); ?></p>
                                                </div>

                                                <?php if (!empty($review->comment)): ?>
                                                    <div class="staff-comment">
                                                        <p><strong>Staff Comment:</strong> <?php echo htmlspecialchars($review->comment); ?></p>
                                                    </div>
                                                <?php endif; ?>
                                            </div>
                                            <hr>
                                        <?php endforeach; ?>
                                    </div>
                                <?php else: ?>
                                    <p>No reviews yet</p>
                                <?php endif; ?>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </section>
        <!--Start of Tawk.to LiveChat Script-->
        <script type="text/javascript">
            var Tawk_API = Tawk_API || {}, Tawk_LoadStart = new Date();
            (function () {
                var s1 = document.createElement("script"), s0 = document.getElementsByTagName("script")[0];
                s1.async = true;
                s1.src = 'https://embed.tawk.to/66e03ef3ea492f34bc1093c5/1i7dvbqc1';
                s1.charset = 'UTF-8';
                s1.setAttribute('crossorigin', '*');
                s0.parentNode.insertBefore(s1, s0);
            })();
        </script>
        <!--End of Tawk.to Script-->
        <?php include "Footer.php"; ?>
        </body>
        </html>
        <?php
    } else {
        echo "Book not found!";
    }
} else {
    echo "No bookId provided!";
}
