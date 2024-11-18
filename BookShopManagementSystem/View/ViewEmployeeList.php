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

// Fetch the employee list, with or without a search term
$searchTerm = $_GET['search'] ?? null;
$employees = $controller->getEmployeeList($searchTerm);
?>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Employee List</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    <body>
        <?php include 'Header.php'; ?>

        <div class="container py-5">
            <div class="row">
                <?php include 'ControlSidebar.php'; ?>
                
                <div class="col-lg-9"><?php if (isset($_GET['status']) && $_GET['status'] === 'success'): ?>
                    <div style="color: green; font-weight: bold;">
                        Staff added successfully!
                    </div>
                <?php endif; ?>
                <?php if (isset($_GET['UpdateStatus']) && $_GET['UpdateStatus'] === 'success'): ?>
                        <div style="color: green; font-weight: bold;">
                            Employee Details Updated successfully!
                        </div>
                    <?php endif; ?>
                    <h1>Employee List</h1>

                    <!-- Search Form -->
                    <form method="GET" action="" class="form-inline mb-3">
                        <input type="text" name="search" class="form-control mr-2" placeholder="Search by ID, name, email, or position" value="<?= htmlspecialchars($searchTerm ?? '') ?>">
                        <button type="submit" class="btn btn-success">Search</button>
                        <a href="ViewEmployeeList.php" class="btn btn-secondary ml-2">Clear</a>
                    </form>

                    <?php if ($employees->isEmpty()) { ?>
                        <div class="alert alert-warning">No employees found matching the search criteria.</div>
                    <?php } ?>

                    <div class="row">
                        <table class="table table-bordered" style="font-size: 15px; margin: 20px; padding: 20px;">
                            <thead class="thead-light">
                                <tr align="center">
                                    <th style="width:5%">ID</th>
                                    <th style="width:15%">Name</th>
                                    <th style="width:20%">Email</th>
                                    <th style="width:10%">Phone Number</th>

                                    <th style="width:10%">Position</th>
                                    <th style="width:10%">Joined Date</th>
                                    <th style="width:10%">Status</th>
                                    <th style="width:10%">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($employees as $employee) { ?>
                                    <tr align="center" style="border: 1px dashed green;">
                                        <td><?= htmlspecialchars($employee->empId) ?></td>
                                        <td><?= htmlspecialchars($employee->name) ?></td>
                                        <td><?= htmlspecialchars($employee->email) ?></td>
                                        <td><?= htmlspecialchars($employee->phoneNum) ?></td>
                                        <td><?= htmlspecialchars($employee->position) ?></td>
                                        <td><?= htmlspecialchars($employee->joinDate) ?></td>
                                        <td><?= htmlspecialchars($employee->status) ?></td>
                                        <td>
                                            <form action="../Controller/EmployeeController.php" method="post">
                                                <input type="hidden" name="action" value="viewEmployeeDetails">
                                                <input type="hidden" name="employeeId" value="<?= htmlspecialchars($employee->empId) ?>">
                                                <input class="btn btn-success btn-lg" type="submit" value="View">
                                            </form>
                                        </td>
                                    </tr>
                                <?php } ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <?php include 'Footer.php'; ?>
    </body>
</html>