<?php
/** @author Choo Shi Yi */

use BookShopManagementSystem\Controller\SessionManagement;
use BookShopManagementSystem\Controller\AccessControl;
require_once '../Controller/SessionManagement.php';
require_once '../Controller/AccessControl.php';
SessionManagement::start();
$accessControl = new AccessControl;
$accessControl ->checkSession();
$accessControl ->ensureAdmin();

require_once '../config/bootstrap.php';
require_once '../Controller/EmployeeController.php';

use BookShopManagementSystem\Controller\EmployeeController;

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
            <title>Employee Details</title>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        </head>
        <body>
        <?php include 'Header.php'; ?>

        <div class="container py-5">
            <div class="row">
                <?php include 'ControlSidebar.php'; ?>

                <div class="col-lg-9">
                    <h1>Employee Details</h1>
                    <div class="row">
                        <div class="card-body">
                            <h6>ID:</h6>
                            <p><input style="width:100%;" type="text" name="employeeId" value="<?= htmlspecialchars($employee->empId) ?>" readonly></p>
                            <h6>Name:</h6>
                            <p><input style="width:100%;" type="text" name="employeeName" value="<?= htmlspecialchars($employee->name) ?>" readonly></p>
                            <h6>Email:</h6>
                            <p><input style="width:100%;" type="text" name="employeeEmail" value="<?= htmlspecialchars($employee->email) ?>" readonly></p>
                            <h6>Phone Number:</h6>
                            <p><input style="width:100%;" type="text" name="employeePhoneNumber" value="<?= htmlspecialchars($employee->phoneNum) ?>" readonly></p>
                            <h6>Position:</h6>
                            <p><input style="width:100%;" type="text" name="employeePosition" value="<?= htmlspecialchars($employee->position) ?>" readonly></p>
                            <h6>Join Date:</h6>
                            <p><input style="width:100%;" type="text" name="employeeJoinDate" value="<?= htmlspecialchars($employee->joinDate) ?>" readonly></p>

                            <div class="row pb-3">
                                <div class="col d-grid">
                                    <form action="../View/UpdateEmployeeDetails.php" method="get">
                                        <input type="hidden" name="employeeId" value="<?= htmlspecialchars($employee->empId) ?>">
                                        <input class="btn btn-success btn-lg" type="submit" value="Edit">
                                    </form>
                                </div>
                                <div class="col d-grid">
                                    <form action="../Controller/EmployeeController.php" method="post">
                                        <input type="hidden" name="employeeId" value="<?= htmlspecialchars($employee->empId) ?>">
                                        <?php if ($employee->status === 'active'): ?>
                                            <input type="submit" class="btn btn-warning btn-lg" name="action" value="deactivateEmployee" onclick="return confirm('Are you sure you want to deactivate this employee?');">
                                        <?php else: ?>
                                            <input type="submit" class="btn btn-info btn-lg" name="action" value="activateEmployee" onclick="return confirm('Are you sure you want to activate this employee?');">
                                        <?php endif; ?>
                                    </form>
                                </div>
                                <div class="col d-grid">
                                    <form action="../Controller/EmployeeController.php" method="post">
                                        <input type="hidden" name="employeeId" value="<?= htmlspecialchars($employee->empId) ?>">
                                        <input type="submit" class="btn btn-danger btn-lg" name="action" value="deleteEmployee" onclick="return confirm('Are you sure you want to delete this employee?');">
                                    </form>
                                </div>
                                
                                
                                
                            </div>
                        </div>
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
