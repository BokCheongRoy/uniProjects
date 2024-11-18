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

$custId = $_SESSION['custId'] ?? null;

if ($custId) {
    require_once '../Model/Account.php';
    require_once '../Model/Customer.php';

    $customer = BookShopManagementSystem\Model\Customer::getCustomerById($custId);
    $user = BookShopManagementSystem\Model\Account::getUserById($customer->accId);

    if (!$user || !$customer) {
        echo "Error: Customer not found.";
        exit();
    }
} else {
    echo "No customer logged in.";
    exit();
}
?>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Profile</title>
        <style>
            .form-control {
                border: 1px solid #77C717 !important; /* Add border color to all input fields */
                width: 100%; /* Ensure width is applied */
            }
        </style>
    </head>
    <body>
        <?php include 'Header.php'; ?>

        <div class="container py-5">
            <div class="row">
                <div class="col-lg-9 d-flex justify-content-between align-items-center">
                    <h1>Profile</h1>
                    <a href="ViewOrderHistory.php" class="btn btn-success">View Order History</a>
                </div>
                <div class="col-lg-9">
                    <div class="row">
                         <?php if (isset($_GET['status']) && $_GET['status'] === 'success'): ?>
                        <div style="color: green; font-weight: bold;">
                            Profile Update successfully!
                        </div>
                    <?php endif; ?>
                        <form action="../Controller/ProfileController.php" method="post">
                            <div class="card-body">
                                <h6>Name: </h6>
                                <p><input class="form-control" type="text" name="customerName" value="<?= htmlspecialchars($user->name) ?>" readonly></p>
                                <h6>Username: </h6>
                                <p><input class="form-control" type="text" name="customerUsername" value="<?= htmlspecialchars($user->username) ?>" readonly></p>
                                <h6>Email: </h6>
                                <p><input class="form-control" type="text" name="customerEmail" value="<?= htmlspecialchars($user->email) ?>" readonly></p>
                                <h6>Phone Number: </h6>
                                <p><input class="form-control" type="text" name="customerPhoneNumber" value="<?= htmlspecialchars($user->phoneNum) ?>" readonly></p>
                                <h6>Address: </h6>
                                <p><input class="form-control" type="text" name="customerAddress" value="<?= htmlspecialchars($customer->address ?? "") ?>" readonly></p>
                                <div class="row pb-3">
                                    <div class="col d-grid">
                                        <a href="UpdateProfile.php" class="btn btn-success btn-lg">Edit</a>
<!--                                        <input type="submit" class="btn btn-success btn-lg" name="button" value="Edit1">-->
                                    </div>
                                    <div class="col d-grid">
                                        <button type="submit" class="btn btn-success btn-lg" name="button" value="Delete" onclick="return confirmDeletion();">Delete Account</button>
                                    </div>
                                    <div class="col d-grid">
                                        <a href="UpdatePassword.php" class="btn btn-success btn-lg">Change Password</a>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <?php include 'Footer.php'; ?>
        <script>
        function confirmDeletion() {
            return confirm("Are you sure you want to delete your account? This action cannot be undone.");
        }
    </script>
    </body>
</html>
