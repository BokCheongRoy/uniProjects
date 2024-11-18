<?php
/** @author All members */

require_once '../Controller/SessionManagement.php';
use BookShopManagementSystem\Controller\SessionManagement;

SessionManagement::start();

$custId = $_SESSION['custId'] ?? null;
$empId = $_SESSION['empId'] ?? null;
$adminId = $_SESSION['adminId'] ?? null;

?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <div class="col-lg-3">
            <h1 class="h2 pb-4">Management</h1>
            <ul>
                <li>Sales
                    <ul>
                        <li><a class="text-decoration-none" href="AddBook.php">Add New Book</a></li>
                        <li><a class="text-decoration-none" href="ViewBookList.php">Book List</a></li>
                        <li><a class="text-decoration-none" href="ViewOrderList.php">Order List</a></li>
                        <li><a class="text-decoration-none" href="ViewRatingList.php">Rating List</a></li>

                    </ul>
                </li>
                <?php if ($adminId): ?>
                <li>Employee
                    <ul>
                        <li><a class="text-decoration-none" href="ViewEmployeeList.php">Employee List</a></li>
                        <li><a class="text-decoration-none" href="RegisterEmployee.php">Register Employee</a></li>
                    </ul>
                </li>
                <?php endif; ?>
                
                <li>Customer
                    <ul>
                        <li><a class="text-decoration-none" href="ViewCustomerList.php">Customer List</a></li>
                    </ul>
                </li>
                <li>Report
                    <ul>
                        <li><a class="text-decoration-none" href="inventory_report.php">Inventory Summary Report</a></li>
                        <li><a class="text-decoration-none" href="ViewOrderSummary.php">Order Summary Report</a></li>
                        <li><a class="text-decoration-none" href="view_report.php">User Summary Report</a></li>
                        <li><a class="text-decoration-none" href="ReviewReport.php">Review Summary Report</a></li>

                    </ul>
                </li>
            </ul>
        </div>
    </body>
</html>
