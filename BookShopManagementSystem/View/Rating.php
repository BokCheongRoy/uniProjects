<?php
/** @author Pua Jia Qian */

require_once '../Controller/ReviewController.php';
require_once '../Model/OrderDetail.php';

$orderId = $_POST['orderId'] ?? $_GET['orderId'] ?? 'O0001';
$reviewController = new \BookShopManagementSystem\Controller\ReviewController();
$orderDetails = $reviewController->getOrderDetails($orderId);
?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Submit Review</title>
        <style>

            .book-review-container {
                display: flex;
                justify-content: space-between;
                width: 100%;
                margin-bottom: 20px;
                border: 1px solid #ddd;
                padding: 20px;
                border-radius: 10px;
            }

            .book-details {
                width: 65%;
                text-align: center;
            }
            .book-details img {
                max-width: 200px;
                height: auto;
                border-radius: 8px;
            }
            .book-details p {
                font-size: 1.2em;
                margin: 10px 0;
            }

            .review-section {
                width: 75%;
            }

            /* Star Rating Section */
            .star-rating {
                display: flex;
                justify-content: left;
                font-size: 1.5em;
                unicode-bidi: bidi-override;
                direction: ltr;
                margin: 5px 0;
            }
            .star-rating input[type="radio"] {
                display: none;
            }
            .star-rating label {
                color: #ddd;
                cursor: pointer;
                transform: scale(1.3);
            }
            .star-rating label:hover,
            .star-rating label:hover ~ label {
                color: #f5c518;
            }
            .star-rating input[type="radio"]:checked ~ label {
                color: #ddd;
            }
            .star-rating input[type="radio"]:checked + label,
            .star-rating input[type="radio"]:checked + label ~ label {
                color: #f5c518;
            }

            textarea {
                width: 100%;
                padding: 15px;
                font-size: 1.1em;
                margin-top: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

        </style>
    </head>
    <body>

        <?php include 'Header.php'; ?>

        <h2 style="text-align: center; margin: 10px;">Rate and Review Your Books</h2>

        <div class="container">
            <form method="POST" action="../Controller/ReviewController.php" enctype="multipart/form-data">

                <input type="hidden" name="orderId" value="<?= htmlspecialchars($orderId) ?>">

                <?php foreach ($orderDetails as $detail): ?>
                    <!-- Book and Review Section Side by Side -->
                    <div class="book-review-container">
                        <!-- Book image and details  -->
                        <div class="book-details">
                            <img src="../BookImage/<?= htmlspecialchars($detail->book->image) ?>" alt="Book Image">
                            <p><strong><?= htmlspecialchars($detail->book->bookName) ?></strong></p>
                            <p>Quantity: <?= htmlspecialchars($detail->quantity) ?></p>
                            <p>Price: RM<?= number_format($detail->book->price, 2) ?></p>
                        </div>     

                        <!-- Rating and Review Section  -->
                        <div class="review-section">
                            <input type="hidden" name="bookReviews[<?= htmlspecialchars($detail->bookId) ?>][bookId]" value="<?= htmlspecialchars($detail->bookId) ?>">

                            <!-- Upload Photo -->
                            <label for="photo-<?= htmlspecialchars($detail->bookId) ?>">Upload Photo:</label><br>
                            <input type="file" name="bookReviews[<?= htmlspecialchars($detail->bookId) ?>]" id="photo-<?= htmlspecialchars($detail->bookId) ?>" class="form-control mb-3" accept=".jpg,.jpeg,.png" required><br>

                            <!-- Star Rating -->
                            <label for="rating-<?= htmlspecialchars($detail->bookId) ?>">Rating:</label><br>
                            <div class="star-rating">
                                <input type="radio" id="1-star-<?= htmlspecialchars($detail->bookId) ?>" name="bookReviews[<?= htmlspecialchars($detail->bookId) ?>][rating]" value="1" checked>
                                <label for="1-star-<?= htmlspecialchars($detail->bookId) ?>" title="1 star">&#9733;</label>
                                <input type="radio" id="2-stars-<?= htmlspecialchars($detail->bookId) ?>" name="bookReviews[<?= htmlspecialchars($detail->bookId) ?>][rating]" value="2">
                                <label for="2-stars-<?= htmlspecialchars($detail->bookId) ?>" title="2 stars">&#9733;</label>
                                <input type="radio" id="3-stars-<?= htmlspecialchars($detail->bookId) ?>" name="bookReviews[<?= htmlspecialchars($detail->bookId) ?>][rating]" value="3">
                                <label for="3-stars-<?= htmlspecialchars($detail->bookId) ?>" title="3 stars">&#9733;</label>
                                <input type="radio" id="4-stars-<?= htmlspecialchars($detail->bookId) ?>" name="bookReviews[<?= htmlspecialchars($detail->bookId) ?>][rating]" value="4">
                                <label for="4-stars-<?= htmlspecialchars($detail->bookId) ?>" title="4 stars">&#9733;</label>
                                <input type="radio" id="5-stars-<?= htmlspecialchars($detail->bookId) ?>" name="bookReviews[<?= htmlspecialchars($detail->bookId) ?>][rating]" value="5">
                                <label for="5-stars-<?= htmlspecialchars($detail->bookId) ?>" title="5 stars">&#9733;</label>
                            </div>

                            <label for="review-<?= htmlspecialchars($detail->bookId) ?>">Review:</label><br>
                            <textarea name="bookReviews[<?= htmlspecialchars($detail->bookId) ?>][review]" id="review-<?= htmlspecialchars($detail->bookId) ?>" rows="4" minlength="10" maxlength="255" required></textarea><br><br>
                        </div>
                    </div>
                <?php endforeach; ?>
                <input type="hidden" name="action" value="create">

                <div style="text-align: center;margin: 10px;">
                    <input type="submit" class="btn btn-success btn-lg"  value="Submit Reviews">
                </div>
            </form>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const starContainers = document.querySelectorAll('.star-rating');
                starContainers.forEach(container => {
                    const stars = container.querySelectorAll('label');
                    stars.forEach((star, index) => {
                        star.addEventListener('mouseover', () => {
                            highlightStars(stars, index);
                        });
                        star.addEventListener('mouseout', () => {
                            resetStars(stars);
                        });
                    });

                    function highlightStars(stars, index) {
                        for (let i = 0; i <= index; i++) {
                            stars[i].style.color = '#f5c518';
                        }
                    }

                    function resetStars(stars) {
                        stars.forEach(star => {
                            star.style.color = '#ddd';
                        });
                        const checkedStar = container.querySelector('input[type="radio"]:checked');
                        if (checkedStar) {
                            const checkedIndex = Array.from(stars).findIndex(star => star.htmlFor === checkedStar.id);
                            highlightStars(stars, checkedIndex);
                        }
                    }
                });
            });

            document.addEventListener('DOMContentLoaded', function () {
                const form = document.querySelector('form');

                form.addEventListener('submit', function (event) {
                    let isValid = true;

                    document.querySelectorAll('.book-review-container').forEach(function (container) {
                        const ratingContainer = container.querySelector('.star-rating');
                        const ratingSelected = ratingContainer.querySelector('input[type="radio"]:checked');
                        let errorMessage = container.querySelector('.rating-error-message');

                        // If no rating is selected, prevent submission and show an error message
                        if (!ratingSelected) {
                            isValid = false;

                            if (!errorMessage) {
                                // Add an error message if not already present
                                errorMessage = document.createElement('p');
                                errorMessage.textContent = 'Please select a rating.';
                                errorMessage.classList.add('rating-error-message');
                                errorMessage.style.color = 'red';
                                ratingContainer.appendChild(errorMessage);
                            }
                        } else if (errorMessage) {
                            errorMessage.remove();
                        }
                    });

                    if (!isValid) {
                        event.preventDefault(); // Prevent form submission if any rating is missing
                    }
                });
            });




        </script>

        <?php include 'Footer.php'; ?>

    </body>
</html>
