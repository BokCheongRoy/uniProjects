<?php
/** @author All members */

require_once __DIR__ . '/../config/bootstrap.php';  // Adjust path as needed
require_once '../Controller/BookController.php';
require_once '../Controller/WishlistController.php';  // Wishlist Controller
require_once '../Model/Wishlist.php'; // Add this line to import Wishlist model

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
use BookShopManagementSystem\Controller\WishlistController;
use BookShopManagementSystem\Controller\BookController;
use BookShopManagementSystem\Model\Wishlist; // Import the Wishlist model

$controller = new BookController();
$wishlistController = new WishlistController();

// Get user ID from session (or however you handle logged-in users)
$custId = $_SESSION['custId'] ?? null;


// Handle search request
if (isset($_GET['searchTerm'])) {
    $searchTerm = $_GET['searchTerm'];
    $books = $controller->searchBooks($searchTerm);
} else {
    // Fetch all books if no search term is provided
    $books = $controller->listBooks();
}

// Fetch user's wishlist (assumed it's stored in a database with userId)
$wishlist = $custId ? Wishlist::getWishlistByCustomerId($custId)->pluck('bookId')->toArray() : [];

?>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Books</title>
        <!-- Include FontAwesome for heart icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            .fixed-size-img {
                width: 200px; 
                height: 500px; 
                object-fit: cover;
            }
        </style>
    </head>
    <body>
        <?php include "Header.php" ?>

        <section class="bg-light">
            <div class="container py-5">
                <div class="row text-center py-3">
                    <div class="col-lg-6 m-auto">
                        <h1 class="h1">Books</h1>
                        <strong>All Books</strong><br>
                        <form action="" method="get">
                            <input type="text" name="searchTerm" placeholder="Search Books...">
                            <button type="submit">Search</button>
                        </form>
                    </div>
                </div>

                <div class="row">
                    <?php foreach ($books as $book): ?>
                        <div class="col-12 col-md-4 mb-4">
                            <div class="card h-100">
                                <a href="ViewBookDetails.php?bookId=<?php echo htmlspecialchars($book->bookId); ?>">
                                    <img src="<?php echo htmlspecialchars($book->image); ?>" class="card-img-top fixed-size-img" alt="Book Cover">
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
        <?php include "Footer.php" ?>
    </body>
</html>
