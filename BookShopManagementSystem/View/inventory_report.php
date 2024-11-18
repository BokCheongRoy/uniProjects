<?php 
/** @author Bok Cheong Roy */

require_once '../Controller/SessionManagement.php';
require_once '../Controller/AccessControl.php';
require_once '../Controller/BookController.php';
use BookShopManagementSystem\Controller\BookController;
use BookShopManagementSystem\Controller\SessionManagement;
use BookShopManagementSystem\Controller\AccessControl;

SessionManagement::start();
$accessControl = new AccessControl;
$accessControl ->checkSession();
$accessControl ->ensureEmployeeOrAdmin();

$controller = new BookController();
// Generate and display the inventory report
$controller->generateInventoryReport()
        ?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>BQY Add Book</title>
    </head>
    <body>
        <?php include "Header.php"; ?>  

        <div class="container py-5">
            <div class="row">
                <?php include 'ControlSidebar.php'; ?>

                <div class="col-lg-9">                   
                        <?php echo $controller->displayInventoryReport();?>
                </div>
            </div>
        </div>

        <?php include "Footer.php"; ?>
    </body>
</html>