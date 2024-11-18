<?php
/** @author Choo Shi Yi */

use BookShopManagementSystem\Controller\SessionManagement;
use BookShopManagementSystem\Controller\AccessControl;

require_once '../Controller/SessionManagement.php';
require_once '../Controller/AccessControl.php';
SessionManagement::start();
$accessControl = new AccessControl;
$accessControl->checkSession();

$custId = $_SESSION['custId'] ?? null;
$empId = $_SESSION['empId'] ?? null;
$adminId = $_SESSION['adminId'] ?? null;
?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Change Password</title>
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
        <?php
        include 'Header.php';
        ?>

        <div class="container py-5">
            <div class="row">
                <?php if ($empId || $adminId): ?>
                    <?php include 'ControlSidebar.php'; ?>
                <?php endif; ?>
                <div class="col-lg-9">
                    <?php
                    //session_start();
                    if (isset($_SESSION['errors']) && !empty($_SESSION['errors'])) {
                        foreach ($_SESSION['errors'] as $error) {
                            echo "<div class='error'>$error</div>";
                        }
                        // Clear errors after displaying
                        unset($_SESSION['errors']);
                    }
                    ?>

                    <form method="post" action="../Controller/ProfileController.php">
                        <h3>Change Password</h3>
                        <script>
                            function togglePassword(inputId) {
                                var x = document.getElementById(inputId);
                                if (x.type === "password") {
                                    x.type = "text";
                                } else {
                                    x.type = "password";
                                }
                            }
                        </script>
                        <!-- Current Password -->
                        <div class="mb-3">
                            <label for="currentPassword">Current Password</label>
                            <input type="password" class="form-control mt-1" id="currentPassword" name="currentPassword" required>
                            <input type="checkbox" onclick="togglePassword('currentPassword')"><span class="show-password">Show Password</span>
                        </div>

                        <!-- New Password -->
                        <div class="mb-3">
                            <label for="newPassword">New Password</label>
                            <input type="password" class="form-control mt-1" id="newPassword" name="newPassword" required>
                            <input type="checkbox" onclick="togglePassword('newPassword')"><span class="show-password">Show Password</span>
                        </div>

                        <!-- Confirm New Password -->
                        <div class="mb-3">
                            <label for="confirmNewPassword">Confirm New Password</label>
                            <input type="password" class="form-control mt-1" id="confirmNewPassword" name="confirmNewPassword" required>
                            <input type="checkbox" onclick="togglePassword('confirmNewPassword')"><span class="show-password">Show Password</span>
                        </div>

                        <!-- Submit Button -->
                        <div class="row">
                            <div class="col text-end mt-2">
                                <button type="submit" class="btn btn-success btn-lg px-3" name="button" value="ChangePassword">Change Password</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <?php include 'Footer.php'; ?>
    </body>

</html>
