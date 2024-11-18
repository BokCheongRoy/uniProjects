<?php
/** @author Lee Weng Yi */
require_once '../Controller/CartController.php';
require_once '../Controller/SessionManagement.php';
require_once '../Controller/CustomerController.php';
require_once __DIR__ . '/../config/bootstrap.php';

use BookShopManagementSystem\Controller\CartController;
use BookShopManagementSystem\Controller\SessionManagement;
use BookShopManagementSystem\Controller\CustomerController;
use BookShopManagementSystem\Controller\AccessControl;

$cartController = new CartController();
$cartItems = $cartController->getCartItemsWithDetails();

require_once '../Controller/SessionManagement.php';
require_once '../Controller/AccessControl.php';

SessionManagement::start();
$sessionManagement = new SessionManagement();
$csrfToken = $sessionManagement->createCsrfToken();

$accessControl = new AccessControl;
$accessControl->checkSession();
$accessControl->ensureCustomer();

// Retrieve the customer’s saved address
$customerController = new CustomerController();
$customer = $customerController->getCustomerById($_SESSION['custId']);
$savedAddress = $customer->address;
?>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>BQY Checkout Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .cart-summary {
                border-right: 1px solid #ccc;
            }
            .productimage {
                padding-left: 10px;
                padding-right: auto;
                min-width: 100px;
            }
            .quantity {
                padding-left: auto;
                padding-right: auto;
                min-width: 100px;
            }
            .productname {
                min-width: 200px;
            }
            .price {
                padding-left: auto;
                padding-right: auto;
                min-width: 100px;
            }
            .products {
                height: 100px;
            }
        </style>

        <script>
            function fillAddress() {
                var savedAddress = "<?php echo isset($savedAddress) ? htmlspecialchars($savedAddress) : ''; ?>"; // Handle null explicitly
                var checkBox = document.getElementById('useSavedAddress');
                var addressField = document.getElementById('address');

                if (checkBox.checked) {
                    addressField.value = savedAddress !== "" ? savedAddress : ""; // Show "null" if no saved address
                } else {
                    addressField.value = '';
                }
            }

            function validateAndSubmitForm(event) {
                var addressField = document.getElementById('address');
                var savedAddress = "<?php echo isset($savedAddress) ? htmlspecialchars($savedAddress) : ''; ?>"; // Handle null explicitly
                var saveNewAddressField = document.getElementById('saveNewAddress');

                if (addressField.value.trim() !== savedAddress.trim()) {
                    var confirmSaveAddress = confirm("Do you want to save this new address?");
                    saveNewAddressField.value = confirmSaveAddress ? "yes" : "no";
                } else {
                    saveNewAddressField.value = "no";
                }

                document.getElementById('checkoutForm').submit();
            }
        </script>



    </head>
    <body>
        <?php include 'Header.php'; ?>

        <div class="container py-5">
            <?php
            if (isset($_SESSION['error_message'])) {
                echo '<div class="alert alert-danger">' . htmlspecialchars($_SESSION['error_message']) . '</div>';
                unset($_SESSION['error_message']);
            }
            ?>

            <div class="row py-5">
                <div class="col-md-6 cart-summary">
                    <h2>Order</h2>
                    <table class="table table-bordered">
                        <tr>
                            <th class="productimage">Book</th>
                            <th class="quantity">Quantity</th>
                            <th class="productname">Name</th>
                            <th class="price">Price</th>
                        </tr>
                        <?php
                        foreach ($cartItems as $item) {
                            ?>
                            <tr class="products">
                                <td class="productimage">
                                    <img width="80px" height="50px" src="<?php echo htmlspecialchars($item->book->image); ?>" alt="Book Image" />
                                </td>
                                <td class="quantity">
                                    <span><?php echo htmlspecialchars($item->quantity); ?></span>
                                </td>
                                <td class="bookName">
                                    <span><?php echo htmlspecialchars($item->book->bookName); ?></span>
                                </td>
                                <td class="price">
                                    RM<?php echo htmlspecialchars(number_format($item->book->price, 2)); ?>
                                </td>
                            </tr>
                            <?php
                        }
                        ?>
                    </table>
                    <div class="text-end mt-3">
                        <?php
                        $totalAmount = $cartItems->sum(function ($item) {
                            return $item->quantity * $item->book->price;
                        });
                        ?>
                        <h5>Total: RM<?php echo htmlspecialchars(number_format($totalAmount, 2)); ?></h5>
                    </div>
                </div>
                <div class="col-md-6">
                    <form method="post" action="../Controller/OrderController.php" id="checkoutForm" onsubmit="validateAndSubmitForm(event);
                            return false;">
                        <h2>Check Out</h2>
                        <div class="mb-3">
                            <label for="recipient">Recipient Name</label>
                            <input type="text" class="form-control" id="recipient" name="recipient" 
                                   value="<?php
                                   if (isset($_SESSION['recipient'])) {
                                       echo htmlspecialchars($_SESSION['recipient']);
                                       unset($_SESSION['recipient']);
                                   }
                                   ?>" required>
                        </div>
                        <div class="mb-3">
                            <label for="phoneNum">Phone Number</label>
                            <input type="text" class="form-control" id="phoneNum" name="phoneNum" placeholder="01x-xxxxxxx" value="<?php
                            if (isset($_SESSION['phoneNum'])) {
                                echo htmlspecialchars($_SESSION['phoneNum']);
                                unset($_SESSION['phoneNum']);
                            }
                            ?>" required>
                        </div>
                        <div class="mb-3">
                            <label for="address">Address</label>
                            <input type="textarea" class="form-control" id="address" name="address" placeholder="Address" value="<?php
                            if (isset($_SESSION['address'])) {
                                echo htmlspecialchars($_SESSION['address']);
                                unset($_SESSION['address']);
                            }
                            ?>" required>
                        </div>
                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" id="useSavedAddress" onclick="fillAddress()">
                            <label class="form-check-label" for="useSavedAddress">
                                Use saved address
                            </label>
                        </div>
                        <input type="hidden" id="saveNewAddress" name="saveNewAddress" value="no">

                        <input type="hidden" name="csrf_token" value="<?php echo htmlspecialchars($csrfToken); ?>">
                        <input type="hidden" name="totalAmount" value="<?php echo htmlspecialchars($totalAmount); ?>">
                        <input type="hidden" name="action" value="processPayment">

                        <div class="row">
                            <div class="col text-end mt-2">
                                <button type="submit" class="btn btn-success btn-lg">Pay</button>
                            </div>
                        </div>
                    </form>

                </div>
            </div>
        </div>

<?php include 'Footer.php'; ?>
    </body>
</html>
