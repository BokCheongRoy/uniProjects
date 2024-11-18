<?php
/** @author Lee Weng Yi */

require_once '../config/bootstrap.php';
require_once '../Controller/OrderController.php';
require_once '../Controller/SessionManagement.php';
require_once '../Controller/AccessControl.php';

use BookShopManagementSystem\Controller\OrderController;
use BookShopManagementSystem\Controller\SessionManagement;
use BookShopManagementSystem\Controller\AccessControl;

SessionManagement::start();

$accessControl = new AccessControl;
$accessControl ->checkSession();
$accessControl ->ensureEmployeeOrAdmin();


$orderController = new OrderController();
$orderController->generateOrderXMLReport();
?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Order Summary Report</title>
    </head>
    <body>
        <?php include "Header.php"; ?>

        <div class="container py-5">
            <div class="row">
                <?php include 'ControlSidebar.php'; ?>

                <div class="col-lg-9">
                    <?php echo $orderController->displayOrderSummary(); ?>
                </div>
            </div>
        </div>

        <?php include "Footer.php"; ?>
    </body>
</html>
