<?php
/** @author Lee Weng Yi */
require_once __DIR__ . '/../config/bootstrap.php';
require_once '../Controller/OrderController.php';
require_once '../Controller/SessionManagement.php';
require_once '../Controller/AccessControl.php';

use BookShopManagementSystem\Controller\OrderController;
use BookShopManagementSystem\Controller\SessionManagement;
use BookShopManagementSystem\Controller\AccessControl;

SessionManagement::start();
$orderController = new OrderController();

$accessControl = new AccessControl;
$accessControl ->checkSession();
$accessControl ->ensureEmployeeOrAdmin();

$status = isset($_GET['status']) ? $_GET['status'] : 'New';

$orders = $orderController->getOrdersByStatus($status);
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order List</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .status-buttons {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <?php include 'Header.php'; ?>

    <div class="container py-5">
        <div class="row">
            <?php include 'ControlSidebar.php'; ?>

            <div class="col-lg-9">
                <div class="status-buttons">
                    <?php foreach (['New', 'Accepted', 'Shipping', 'Delivered', 'Cancelled', 'Rated'] as $btnStatus) { ?>
                        <a href="?status=<?php echo htmlspecialchars($btnStatus); ?>" class="btn btn-primary mr-2">
                            <?php echo htmlspecialchars($btnStatus); ?> Orders
                        </a>
                    <?php } ?>
                </div>

                <h1><?php echo htmlspecialchars($status); ?> Orders</h1>
                <div class="row">
                    <table class="table table-bordered" style='font-size: 15px; margin:20px; padding:20px;'>
                        <thead class="thead-light">
                            <tr align="center">
                                <th style="width:10%">Order ID</th>
                                <th style="width:20%">Address</th>
                                <th style="width:10%">Status</th>
                                <th style="width:10%">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php if (!empty($orders)) { ?>
                                <?php foreach ($orders as $order) { ?>
                                    <tr align="center">
                                        <td><?php echo htmlspecialchars($order['orderId']); ?></td>
                                        <td><?php echo htmlspecialchars($order['address']); ?></td>
                                        <td><?php echo htmlspecialchars($order['status']); ?></td>
                                        <td>
                                            <a href="UpdateOrderStatus.php?orderId=<?php echo htmlspecialchars($order['orderId']); ?>" class="btn btn-success btn-lg">
                                                View
                                            </a>
                                        </td>
                                    </tr>
                                <?php } ?>
                            <?php } else { ?>
                                <tr>
                                    <td colspan="4" align="center">No orders found.</td>
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
