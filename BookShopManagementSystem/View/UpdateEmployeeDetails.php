<?php
/** @author Choo Shi Yi */

require_once '../config/bootstrap.php';
require_once '../Controller/EmployeeController.php';

use BookShopManagementSystem\Controller\EmployeeController;
use BookShopManagementSystem\Controller\SessionManagement;
use BookShopManagementSystem\Controller\AccessControl;
require_once '../Controller/SessionManagement.php';
require_once '../Controller/AccessControl.php';
SessionManagement::start();
$accessControl = new AccessControl;
$accessControl ->checkSession();
$accessControl ->ensureAdmin();

// Instantiate the controller
$controller = new EmployeeController();

// Check if employeeId is set in the GET request
if (isset($_GET['employeeId'])) {
    $employeeId = $_GET['employeeId'];

    // Fetch the employee details using the employeeId
    $employee = $controller->getEmployeeDetails($employeeId);

    if ($employee) {
        ?>
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="UTF-8">
            <title>Update Employee Details</title>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        </head>
        <body>
        <?php include 'Header.php'; ?>

        <div class="container py-5">
            <div class="row">
                <?php include 'ControlSidebar.php'; ?>
                <div class="col-lg-9">
                  <?php if ($employee): ?>
                    <h1>Update Employee Details</h1>
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
                        <form action="../Controller/EmployeeController.php" method="post">
                            <div class="card-body">
                <?php if (!empty($successMessage)): ?>
                    <div class="success-message">
                        <p><?= htmlspecialchars($successMessage) ?></p>
                    </div>
                <?php endif; ?>
                                <input type="hidden" name="employeeId" value="<?= htmlspecialchars($employee->empId) ?>">

                                <h6>Name:</h6>
                                <p><input style="width:100%;" type="text" name="employeeName" value="<?= htmlspecialchars($employee->name) ?>" required></p>
                                <h6>Email:</h6>
                                <p><input style="width:100%;" type="email" name="employeeEmail" value="<?= htmlspecialchars($employee->email) ?>"required></p>
                                <h6>Phone Number:</h6>
                                <p><input style="width:100%;" type="text" name="employeePhoneNumber" value="<?= htmlspecialchars($employee->phoneNum) ?>" pattern="01[0-9]{1}-[0-9]{7,8}" title="Please enter a valid phone number (e.g., 01X-XXXXXXX)" 
                                           placeholder="01X-XXXXXXX" required></p>
                                <h6>Position:</h6>
                                <p><input style="width:100%;" type="text" name="employeePosition" value="<?= htmlspecialchars($employee->position) ?>"required></p>

                                <div class="row pb-3">
                                    <div class="col d-grid">
                                        <input class="btn btn-success btn-lg" type="submit" name="action" value="Update" onclick="return confirm('Are you sure you want to update this employee?');">
                                    </div>
                                    <div class="col d-grid">
                                        <a class="btn btn-secondary btn-lg" href="ViewEmployeeDetails.php?employeeId=<?= htmlspecialchars($employee->empId) ?>">Cancel</a>
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
        <?php
    } else {
        echo "Employee not found!";
    }
} else {
    echo "Employee ID not provided!";
}
?>
