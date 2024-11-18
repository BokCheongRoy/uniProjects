<?php
/** @author Choo Shi Yi */

use BookShopManagementSystem\Controller\SessionManagement;
use BookShopManagementSystem\Controller\AccessControl;
require_once '../Controller/SessionManagement.php';
require_once '../Controller/AccessControl.php';
SessionManagement::start();
$accessControl = new AccessControl;
$accessControl ->checkSession();
$accessControl ->ensureCustomer();

// Debugging: Check session variables
if (!isset($_SESSION['custId'])) {
    echo "No customer logged in. Session data: ";
    var_dump($_SESSION);
    exit();
}

// Get the customer ID from the session
$custId = $_SESSION['custId'];

// Include models
require_once '../Model/Wishlist.php';
require_once '../Model/Book.php';

// Retrieve the wishlist items
use BookShopManagementSystem\Model\Wishlist;

$wishlistItems = Wishlist::getWishlistByCustomerId($custId);
?>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>BQY WishList</title>
        <style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
    }
.productimage img {
    width: 100px; /* Adjust width as needed */
    height: auto; /* Maintain aspect ratio */
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}
    .container {
        max-width: 1200px;
        margin: auto;
        padding: 20px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
    }

    table, th, td {
        border: 1px solid #ddd;
    }

    th, td {
        padding: 12px;
        text-align: left;
    }

    th {   
        font-weight: bold;
    }

    tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    tr:hover {
        background-color: #ddd;
    }

 

    .productname {
        font-weight: bold;
    }

    .remove form {
        margin: 0;
    }

    .btn {
        padding: 8px 16px;
        font-size: 14px;
        border-radius: 4px;
        border: none;
        cursor: pointer;
    }

    .btn-danger {
        background-color: #dc3545;
        color: white;
    }

    .btn-danger:hover {
        background-color: #c82333;
    }

    h1 {
        margin-bottom: 20px;
        font-size: 28px;
        color: #333;
    }
    
</style>

    </head>
    <body>
        <?php include 'Header.php'; ?>

        <div class="container py-5">
            <h1>Wishlist</h1>
            <table style="border: 1px solid green;">
                <tr>
                    <th class="productimage">Book</th>
                    <th class="productname">Name</th>
                    <th class="price">Price</th>
                    <th class="remove">Action</th>
                </tr>
                <?php if ($wishlistItems->isEmpty()): ?>
                    <tr>
                        <td colspan="5" class="text-center">No items in your wishlist.</td>
                    </tr>
                <?php else: ?>
                    <?php foreach ($wishlistItems as $item): ?>
                        <tr class="products">
                            <td class="productimage">
    <a href="ViewBookDetails.php?bookId=<?php echo htmlspecialchars($item->bookId); ?>">
        <img src="<?php echo htmlspecialchars($item->book->image ?? 'default.jpg'); ?>" alt="Book Cover" />
    </a>
</td>

                            <td class="productname">
                                <div class="description">
                                    <span><?php echo htmlspecialchars($item->book->bookName ?? 'Unknown'); ?></span>
                                </div>
                            </td>
                            <td class="price">
                                <div class="total-price">RM<?php echo htmlspecialchars(number_format($item->book->price ?? 0, 2)); ?></div>
                            </td>
                            <td class="remove">
                                <form action="../Controller/WishlistController.php?action=removeItem" method="POST">
                                    <input type="hidden" name="bookId" value="<?php echo htmlspecialchars($item->bookId); ?>">
                                    <input type="submit" class="btn btn-danger btn-lg" value="Remove">
                                </form>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                <?php endif; ?>
            </table>
        </div>

        <?php include 'Footer.php'; ?>
    </body>
</html>
