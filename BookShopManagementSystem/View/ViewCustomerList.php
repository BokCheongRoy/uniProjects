<?php
/** @author Choo Shi Yi */

require_once '../config/bootstrap.php';
require_once '../Controller/CustomerController.php';

use BookShopManagementSystem\Controller\SessionManagement;
use BookShopManagementSystem\Controller\AccessControl;
require_once '../Controller/SessionManagement.php';
require_once '../Controller/AccessControl.php';
SessionManagement::start();
$accessControl = new AccessControl;
$accessControl ->checkSession();
$accessControl ->ensureEmployeeOrAdmin();

use BookShopManagementSystem\Controller\CustomerController;

// Instantiate the controller
$controller = new CustomerController();

// Fetch the customer list
$searchTerm = $_GET['search'] ?? null;
$customers = $controller->getCustomerList($searchTerm);
?>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Customer List</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    <body>
        <?php include 'Header.php'; ?>

        <div class="container py-5">
            <div class="row">
                <?php include 'ControlSidebar.php'; ?>

                <div class="col-lg-9">
                    <h1>Customer List</h1>

                    <!-- Search Form -->
                    <form method="GET" action="" class="form-inline mb-3">
                        <input type="text" name="search" class="form-control mr-2" placeholder="Search by ID, name, username, or email" value="<?= htmlspecialchars($searchTerm ?? '') ?>">
                        <button type="submit" class="btn btn-success">Search</button>
                        <a href="ViewCustomerList.php" class="btn btn-secondary ml-2">Clear</a>
                    </form>

                    <?php if ($customers->isEmpty()) { ?>
                        <div class="alert alert-warning">No customers found matching the search criteria.</div>
                    <?php } ?>

                    <div class="row">
                        <table class="table table-bordered" style="font-size: 15px; margin: 20px; padding: 20px;">
                            <thead class="thead-light">
                                <tr align="center">
                                    <th style="width:3%">Customer ID</th>
                                    <th style="width:15%">Name</th>
                                    <th style="width:15%">Username</th>
                                    <th style="width:20%">Email</th>
                                    <th style="width:10%">Phone Number</th>
                                    <th style="width:20%">Address</th>
                                    <th style="width:5%">Status</th>
                                    <th style="width:12%">Action</th> <!-- New Action Column -->
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($customers as $customer) { ?>
                                    <tr align="center" style="border: 1px dashed green;">
                                        <td><?= htmlspecialchars($customer->custId) ?></td>
                                        <td><?= htmlspecialchars($customer->name) ?></td>
                                        <td><?= htmlspecialchars($customer->username) ?></td>
                                        <td><?= htmlspecialchars($customer->email) ?></td>
                                        <td><?= htmlspecialchars($customer->phoneNum) ?></td>
                                        <td><?= htmlspecialchars($customer->address) ?></td>
                                        <td><?= htmlspecialchars($customer->status) ?></td>
                                        <td>
                                            <?php if ($customer->status === 'active') { ?>
                                                <form action="../Controller/CustomerController.php" method="post" style="display:inline;">
                                                    <input type="hidden" name="custId" value="<?= htmlspecialchars($customer->custId) ?>">
                                                    <input type="submit" class="btn btn-warning" name="action" value="Deactivate" onclick="return confirm('Are you sure you want to deactivate this customer?');">
                                                </form>
                                            <?php } elseif ($customer->status === 'deactive') { ?>
                                                <form action="../Controller/CustomerController.php" method="post" style="display:inline;">
                                                    <input type="hidden" name="custId" value="<?= htmlspecialchars($customer->custId) ?>">
                                                    <input type="submit" class="btn btn-success" name="action" value="Activate" onclick="return confirm('Are you sure you want to activate this customer?');">
                                                </form>
                                            <?php } ?>
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
