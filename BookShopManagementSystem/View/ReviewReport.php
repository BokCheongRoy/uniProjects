<?php
/** @author Pua Jia Qian */
use BookShopManagementSystem\Controller\ReviewController;
use BookShopManagementSystem\Controller\SessionManagement;
use BookShopManagementSystem\Controller\AccessControl;
require_once '../config/bootstrap.php';  
require_once '../Controller/ReviewController.php';
require_once '../Controller/SessionManagement.php';
require_once '../Controller/AccessControl.php';

SessionManagement::start();
$accessControl = new AccessControl;
$accessControl ->checkSession();
$accessControl ->ensureEmployeeOrAdmin();
$controller = new ReviewController();

$controller->generateXMLReport();?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>BQY Review Report</title>
    </head>
    <body>
        <?php include "Header.php"; ?>  

        <div class="container py-5">
            <div class="row">
                <?php include 'ControlSidebar.php'; ?>

                <div class="col-lg-9">                   
                        <?php echo $controller->displayReviewReport();?>
                </div>
            </div>
        </div>

        <?php include "Footer.php"; ?>
    </body>
</html>