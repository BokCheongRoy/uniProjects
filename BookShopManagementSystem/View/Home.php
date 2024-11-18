<?php
/** @author All members */

require_once __DIR__ . '/../config/bootstrap.php';
require_once '../Controller/BookController.php';
require_once '../Model/ReviewFacade.php';
require_once '../Controller/WishlistController.php';
require_once '../Model/Wishlist.php';

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

use BookShopManagementSystem\Controller\BookController;
use BookShopManagementSystem\Model\ReviewFacade;
use BookShopManagementSystem\Controller\WishlistController;
use BookShopManagementSystem\Model\Wishlist;

// Initialize controllers
$controller = new BookController();
$reviewFacade = new ReviewFacade();
$wishlistController = new WishlistController();

$custId = $_SESSION['custId'] ?? null;

// Fetch the 3 featured books
$featuredBooks = $controller->listHomeBooks();

// Fetch the most popular book
$mostPopularBook = $controller->getTopMostPurchasedBooks();

// Get the book details for the most popular book
$popularBookDetails = $controller->getBookById($mostPopularBook->bookId);

// Get the wishlist, or initialize it as an empty array if the user is not logged in or there's no wishlist
if ($custId) {
    $wishlistCollection = $controller->getRandomWishlistByCustomerId($custId) ?? null;
    $wishlist = $wishlistCollection->pluck('bookId')->toArray() ?? []; // Extract bookId into an array
} else {
    $wishlist = [];
    $wishlistCollection = null;
}
?>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <style>
            img {
                display: block;
                margin: 0 auto;
            }
        </style>
    </head>
    <body>
        <?php include 'Header.php'; ?>

        <!-- Display Most Popular Book -->
        <div id="template-mo-zay-hero-carousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <div class="container">
                        <div class="row p-5">
                            <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                                <a href="ViewBookDetails.php?bookId=<?php echo htmlspecialchars($popularBookDetails->bookId); ?>">
                                    <img class="img-fluid" src="<?php echo htmlspecialchars($popularBookDetails->image); ?>" alt="">
                                </a>
                            </div>
                            <div class="col-lg-6 mb-0 d-flex align-items-center">
                                <div class="text-align-left align-self-center">
                                    <h1 class="h1 text-success"><b>Most Popular</b></h1>
                                    <h2 class="h2 text-success"><?php echo htmlspecialchars($popularBookDetails->bookName); ?></h2>
                                    <h3 class="h3"><?php echo htmlspecialchars($popularBookDetails->category); ?></h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Display Featured Books Section -->
        <section class="bg-light">
            <div class="container py-5">
                <div class="row text-center py-3">
                    <div class="col-lg-6 m-auto">
                        <h1 class="h1">Featured Books</h1>
                        <p>Famous books</p>
                    </div>
                </div>
                <div class="row">
                    <?php if (!empty($featuredBooks)): ?>
                        <?php foreach ($featuredBooks as $book): ?>
                            <div class="col-12 col-md-4 mb-4">
                                <div class="card h-100">
                                    <a href="ViewBookDetails.php?bookId=<?php echo htmlspecialchars($book->bookId); ?>">
                                        <img src="<?php echo htmlspecialchars($book->image); ?>" class="card-img-top" alt="Book Cover">
                                    </a>
                                    <div class="card-body">
                                        <ul class="list-unstyled d-flex justify-content-between">
                                            <li class="text-muted text-right">RM<?php echo htmlspecialchars($book->price); ?></li>
                                        </ul>
                                        <a class="h2 text-decoration-none text-dark"><?php echo htmlspecialchars($book->bookName); ?></a>
                                        <p class="card-text">
                                            <?php echo htmlspecialchars($book->author); ?><br><br>
                                            <?php echo htmlspecialchars($book->category); ?>
                                        </p>
                                        <p class="text-muted">Stocks Available: <?php echo htmlspecialchars($book->stock); ?></p>
                                        <!-- Heart Icon for Wishlist -->
                                        <form action="../Controller/WishlistController.php" method="POST">
                                            <input type="hidden" name="bookId" value="<?php echo htmlspecialchars($book->bookId); ?>">
                                            <input type="hidden" name="action" value="toggleWishlist">
                                            <button type="submit" style="border: none; background: none;">
                                                <?php if (in_array($book->bookId, $wishlist)): ?>
                                                    <!-- Already in wishlist, solid heart -->
                                                    <i class="fa-solid fa-heart" style="color: red;"></i>
                                                <?php else: ?>
                                                    <!-- Not in wishlist, regular heart -->
                                                    <i class="fa-regular fa-heart"></i>
                                                <?php endif; ?>
                                            </button>
                                        </form>

                                        <a href="ViewBookDetails.php?bookId=<?php echo htmlspecialchars($book->bookId); ?>">Details</a>
                                    </div>
                                </div>
                            </div>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <p>No books available at the moment.</p>
                    <?php endif; ?>

                    <?php if ($wishlistCollection != null && $wishlistCollection->isNotEmpty()): ?>
                        <div class="row text-center py-3">
                            <div class="col-lg-6 m-auto">
                                <p>WishList</p>
                            </div>
                        </div>
                        <?php foreach ($wishlistCollection as $book): ?>
                            <div class="col-12 col-md-4 mb-4">
                                <div class="card h-100">
                                    <a href="ViewBookDetails.php?bookId=<?php echo htmlspecialchars($book->bookId); ?>">
                                        <img src="<?php echo htmlspecialchars($book->image); ?>" class="card-img-top" alt="Book Cover">
                                    </a>
                                    <div class="card-body">
                                        <ul class="list-unstyled d-flex justify-content-between">
                                            <li class="text-muted text-right">RM<?php echo htmlspecialchars($book->price); ?></li>
                                        </ul>
                                        <a class="h2 text-decoration-none text-dark"><?php echo htmlspecialchars($book->bookName); ?></a>
                                        <p class="card-text">
                                            <?php echo htmlspecialchars($book->author); ?><br><br>
                                            <?php echo htmlspecialchars($book->category); ?>
                                        </p>
                                        <p class="text-muted">Stocks Available: <?php echo htmlspecialchars($book->stock); ?></p>
                                        <!-- Heart Icon for Wishlist -->
                                        <form action="../Controller/WishlistController.php" method="POST">
                                            <input type="hidden" name="bookId" value="<?php echo htmlspecialchars($book->bookId); ?>">
                                            <input type="hidden" name="action" value="toggleWishlist">
                                            <button type="submit" style="border: none; background: none;">
                                                <?php if (in_array($book->bookId, $wishlist)): ?>
                                                    <!-- Already in wishlist, solid heart -->
                                                    <i class="fa-solid fa-heart" style="color: red;"></i>
                                                <?php else: ?>
                                                    <!-- Not in wishlist, regular heart -->
                                                    <i class="fa-regular fa-heart"></i>
                                                <?php endif; ?>
                                            </button>
                                        </form>

                                        <a href="ViewBookDetails.php?bookId=<?php echo htmlspecialchars($book->bookId); ?>">Details</a>
                                    </div>
                                </div>
                            </div>
                        <?php endforeach; ?>
                    <?php endif; ?>
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
        <?php include 'Footer.php'; ?>
    </body>
</html>
