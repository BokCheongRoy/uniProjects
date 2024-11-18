<?php
/** @author Choo Shi Yi */

use BookShopManagementSystem\Controller\SessionManagement;
use BookShopManagementSystem\Controller\AccessControl;

require_once '../Controller/SessionManagement.php';
require_once '../Controller/AccessControl.php';
SessionManagement::start();
$accessControl = new AccessControl;
$accessControl->checkSession();
$accessControl->ensureAdmin();
?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>BQY Register Employee</title>
        <link rel="stylesheet" href="path/to/bootstrap.min.css"> <!-- Add Bootstrap for better styling -->
    </head>
    <style>
        .form-control {
            border: 1px solid #77C717 !important; /* Add border color to all input fields */
        }
    </style>
    <body>
        <?php include 'Header.php'; ?>

        <div class="container py-5">
            <div class="row">
                <?php include 'ControlSidebar.php'; ?>

                <div class="col-lg-9">

                    <h1>Register Employee</h1>
                    <?php if (isset($_GET['status']) && $_GET['status'] === 'success'): ?>
                        <div style="color: green; font-weight: bold;">
                            <?= htmlspecialchars($_GET['message'] ?? 'Operation successful!') ?>
                        </div>
                    <?php elseif (isset($_GET['status']) && $_GET['status'] === 'error'): ?>
                        <div class="alert alert-danger" role="alert">
                            <?= htmlspecialchars($_GET['message'] ?? 'An error occurred.') ?>
                        </div>
                    <?php endif; ?>

                    <div class="row">
                        <form action="../Controller/EmployeeController.php" method="post">
                            <input type="hidden" name="action" value="registerEmployee">
                            <div class="card-body">
                                <h6>Name: </h6>
                                <p>
                                    <input style="width:100%;" type="text" name="employeeName" 
                                           pattern="[a-zA-Z\s]+" title="Name should only contain letters." 
                                           placeholder="Staff Name" required>
                                </p>

                                <h6>Username: </h6>
                                <p>
                                    <input style="width:100%;" type="text" name="employeeUsername" 
                                           pattern="[a-zA-Z0-9]+" title="Username should only contain letters and numbers." 
                                           placeholder="Staff Username" required>
                                </p>

                                <h6>Email: </h6>
                                <p>
                                    <input style="width:100%;" type="email" name="employeeEmail" 
                                           placeholder="xxxxx@email.com" required>
                                </p>

                                <h6>Phone Number: </h6>
                                <p>
                                    <input style="width:100%;" type="text" name="employeePhonenumber" 
                                           pattern="01[0-9]{1}-[0-9]{7,8}" title="Please enter a valid phone number (e.g., 01X-XXXXXXX)" 
                                           placeholder="01X-XXXXXXX" required>
                                </p>

                                <h6>Position: </h6>
                                <p>
                                    <input style="width:100%;" type="text" name="employeePosition" 
                                           pattern="[a-zA-Z\s]+" title="Position should only contain letters." 
                                           placeholder="Staff Position" required>
                                </p>

                                <div class="row pb-3">
                                    <div class="col d-grid">
                                        <input type="submit" class="btn btn-success btn-lg" value="Add">
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <?php include 'Footer.php'; ?>
    </body>
</html>
