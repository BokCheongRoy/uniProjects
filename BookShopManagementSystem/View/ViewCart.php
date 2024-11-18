<?php
/** @author Lee Weng Yi */

require_once '../Controller/CartController.php';
require_once __DIR__ . '/../config/bootstrap.php';
require_once '../Controller/SessionManagement.php';
require_once '../Controller/AccessControl.php';

use BookShopManagementSystem\Controller\CartController;
use BookShopManagementSystem\Controller\SessionManagement;
use BookShopManagementSystem\Controller\AccessControl;

SessionManagement::start();

$accessControl = new AccessControl;
$accessControl ->checkSession();
$accessControl ->ensureCustomer();
$cartController = new CartController();
$cartItems = $cartController->getCartItemsWithDetails();
?>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>BQY Cart</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
            }
            .productimage img {
                width: 100px;
                height: auto; 
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
                border: 1px solid green; 
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
                margin-left: 12%;
            }
            .empty-cart {
                text-align: center;
                font-size: 18px;
            }
        </style>
    </head>
    <body>
<?php include 'Header.php'; ?>

        <div class="container py-5">
            <h1>Cart</h1>
            <table>
                <tr>
                    <th class="productimage">Book</th>
                    <th class="quantity">Quantity</th>
                    <th class="productname">Name</th>
                    <th class="price">Price</th>
                    <th class="remove">Action</th>
                </tr>

<?php if ($cartItems->isEmpty()) { ?>
                    <tr>
                        <td colspan="5" class="empty-cart">Your cart is empty.</td>
                    </tr>
                <?php } else {
                    foreach ($cartItems as $item) {
                        ?>
                        <tr class="products">
                            <td class="productimage">
                                <div class="image">
                                    <a href="ViewBookDetails.php?bookId=<?php echo htmlspecialchars($item->bookId); ?>">
                                    <img width="100px" height="auto" src="<?php echo htmlspecialchars($item->book->image); ?>" alt="Book Cover" />
                                    </a>
                                </div>
                            </td>
                            <td class="quantity">
                                <div class="description">
                                    <span><?php echo htmlspecialchars($item->quantity); ?></span>
                                    <input type="hidden" class="form-control mt-1" name="quantity" value="<?php echo htmlspecialchars($item->quantity); ?>">
                                </div>
                            </td>
                            <td class="productname">
                                <div class="description">
                                    <span><?php echo htmlspecialchars($item->book->bookName); ?></span>
                                </div>
                            </td>
                            <td class="price">
                                <div class="total-price">RM<?php echo htmlspecialchars(number_format($item->book->price, 2)); ?></div>
                            </td>
                            <td class="remove">
                                <form action="../Controller/CartController.php" method="POST">
                                    <input type="hidden" name="bookId" value="<?php echo htmlspecialchars($item->bookId); ?>">
                                    <input type="hidden" name="action" value="removeCart">
                                    <input type="submit" class="btn btn-danger btn-lg" value="Remove">
                                </form>
                            </td>
                        </tr>
    <?php }
}
?>
            </table>

            <div class="row">
                <div class="col text-end mt-2">
                    <?php
                    if (!$cartItems->isEmpty()) {
                        $totalAmount = $cartItems->sum(function ($item) {
                            return $item->quantity * $item->book->price;
                        });
                        ?>
                        <span>Total: RM<?php echo htmlspecialchars(number_format($totalAmount, 2)); ?></span>
                        <a class="btn btn-success btn-lg px-3" href="CheckOutDetails.php" style="margin-right: 12%;">Proceed</a>
<?php } else { ?>
                        <span>Total: RM0.00</span>
                        <button class="btn btn-success btn-lg px-3" style="margin-right: 12%;" disabled>Proceed</button>
<?php } ?>
                </div>
            </div>
        </div>

        <!-- Start of Tawk.to LiveChat Script -->
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
        <!-- End of Tawk.to Script -->

<?php include 'Footer.php'; ?>
    </body>
</html>
