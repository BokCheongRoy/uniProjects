<?php
/** @author Choo Shi Yi */

use BookShopManagementSystem\Controller\SessionManagement;
use BookShopManagementSystem\Controller\AccessControl;
require_once '../Controller/SessionManagement.php';
require_once '../Controller/AccessControl.php';
SessionManagement::start();
$accessControl = new AccessControl;
$accessControl ->checkSession();
$accessControl ->ensureEmployeeOrAdmin();

$empId = $_SESSION['empId'] ?? null;
$adminId = $_SESSION['adminId'] ?? null;

// Common user variables (for both admin and employee)
$user = null;
$employee = null;
$isEmployee = false;

if ($empId) {
    require_once '../Model/Account.php';
    require_once '../Model/Employee.php';

    // Fetch employee and user data
    $employee = BookShopManagementSystem\Model\Employee::getEmployeeByEmpId($empId);
    $user = BookShopManagementSystem\Model\Account::getUserById($employee->accId);

    if (!$user || !$employee) {
        echo "Error: Employee not found.";
        exit();
    }
    $isEmployee = true; // Set flag to indicate the user is an employee
} elseif ($adminId) {
    require_once '../Model/Account.php';

    // Fetch admin user data
    $user = BookShopManagementSystem\Model\Account::getUserById($adminId);

    if (!$user) {
        echo "Error: Admin not found.";
        exit();
    }
} else {
    echo "No user logged in.";
    exit();
}
?>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update Employee Profile</title>
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
                   <?php include 'ControlSidebar.php'; ?>
                <div class="col-lg-9">
                   <?php if ($isEmployee): ?>
                    <h1>Employee Profile</h1>
                <?php else: ?>
                    <h1>Admin Profile</h1>
                <?php endif; ?>
                    <div class="row">
                    <?php if (isset($_GET['status']) && $_GET['status'] === 'success'): ?>
                        <div style="color: green; font-weight: bold;">
                            <?= htmlspecialchars($_GET['message'] ?? 'Operation successful!') ?>
                        </div>
                    <?php elseif (isset($_GET['status']) && $_GET['status'] === 'error'): ?>
                        <div class="alert alert-danger" role="alert">
                            <?= htmlspecialchars($_GET['message'] ?? 'An error occurred.') ?>
                        </div>
                    <?php endif; ?>
                        <form action="../Controller/EmployeeController.php" method="POST">
                            <div class="card-body">
                                <input type="hidden" name="userId" value="<?= htmlspecialchars($user->accId) ?>">                                
                                <h6>Name: </h6>
                                <p><input class="form-control" type="text" name="userName" value="<?= htmlspecialchars($user->name) ?>" required></p>

                                <h6>Email: </h6>
                                <p><input class="form-control" type="text" name="userEmail" value="<?= htmlspecialchars($user->email) ?>" required></p>
                                <h6>Phone Number: </h6>
                                <p><input class="form-control" type="text" name="userPhoneNumber" value="<?= htmlspecialchars($user->phoneNum) ?>" required></p>

                                <div class="row pb-3"> 

                                    <div class="col d-grid">
                                        <input class="btn btn-success btn-lg" type="submit" name="action" value="UpdateProfile" onclick="return confirm('Are you sure you want to update this employee?');">
                                    </div>

                                    <div class="col d-grid">
                                        <a href="ViewEmployeeProfile.php" class="btn btn-success btn-lg">Cancel</a>

                                    </div>  
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
