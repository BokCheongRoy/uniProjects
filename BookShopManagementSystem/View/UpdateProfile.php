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

// Fetch messages from session
$successMessage = $_SESSION['profile_update_success'] ?? $_SESSION['password_change_success'] ?? null;
$errorMessages = $_SESSION['errors'] ?? [];
$_SESSION['errors'] = [];
$_SESSION['profile_update_success'] = null;
$_SESSION['password_change_success'] = null;
?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update Profile</title>
        <style>
            .form-control {
                border: 1px solid #77C717 !important;
                width: 100%; /* Add border color to all input fields */
            }
            .alert {
                padding: 15px;
                margin-bottom: 20px;
                border: 1px solid transparent;
                border-radius: 4px;
            }
            .alert-success {
                color: #3c763d;
                background-color: #dff0d8;
                border-color: #d6e9c6;
            }
            .alert-danger {
                color: #a94442;
                background-color: #f2dede;
                border-color: #ebccd1;
            }
        </style>
    </head>
    <body>
        <?php include 'Header.php'; ?>

        <div class="container py-5">
            <div class="row">
                <!-- Display success message -->
                <?php if ($successMessage): ?>
                    <div class="alert alert-success">
                        <?= htmlspecialchars($successMessage) ?>
                    </div>
                <?php endif; ?>

                <!-- Display error messages -->
                <?php if (!empty($errorMessages)): ?>
                    <div class="alert alert-danger">
                        <ul>
                            <?php foreach ($errorMessages as $error): ?>
                                <li><?= htmlspecialchars($error) ?></li>
                            <?php endforeach; ?>
                        </ul>
                    </div>
                <?php endif; ?>

                <form action="../Controller/ProfileController.php" method="post">
                    <div class="card-body">
                        <h6>Name: </h6>
                        <p><input class="form-control" type="text" name="name" value="<?= htmlspecialchars($user->name) ?>" required></p>
                        <h6>Email: </h6>
                        <p><input class="form-control" type="text" name="email" value="<?= htmlspecialchars($user->email) ?>" required></p>
                        <h6>Phone Number: </h6>
                        <p><input class="form-control" type="text" name="phoneNum" value="<?= htmlspecialchars($user->phoneNum) ?>" required pattern="01[0-9]{1}-[0-9]{7,8}" title="Please enter a valid phone number (e.g., 01X-XXXXXXX)" placeholder="01X-XXXXXXX"></p>
                        <h6>Address: </h6>
                        <p><input class="form-control" type="text" name="address" value="<?= htmlspecialchars($customer->address ?? "") ?>" required></p>
                        <div class="row pb-3">
                            <div class="col d-grid">
                                <input type="submit" class="btn btn-success btn-lg" name="button" value="Edit">
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
<script>
        function confirmDeletion() {
            return confirm("Are you sure you want to delete your account? This action cannot be undone.");
        }
    </script>
        <?php include 'Footer.php'; ?>
    </body>
</html>
