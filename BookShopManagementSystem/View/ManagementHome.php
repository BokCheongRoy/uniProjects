<?php
/** @author All members */

require_once '../config/bootstrap.php';  // Adjust path as needed
require_once '../Controller/BookController.php';
require_once '../Controller/SessionManagement.php';
require_once '../Controller/AccessControl.php';
require_once '../Model/Employee.php';
require_once '../Model/Account.php';
use BookShopManagementSystem\Model\Employee;
use BookShopManagementSystem\Model\Account;
use BookShopManagementSystem\Controller\BookController;
use BookShopManagementSystem\Controller\SessionManagement;
use BookShopManagementSystem\Controller\AccessControl;

SessionManagement::start();
$empId = $_SESSION['empId'] ?? null;
$adminId = $_SESSION['adminId'] ?? null;
//if (isset($_SESSION['empId'])) {
//            $employee = Employee::where('empId', $empId)->first();
//            $email = Account::where('accId', $employee->accId)->pluck('email')->first();
//        } elseif (isset($_SESSION['adminId'])){
//            $email = Account::where('accId', $adminId)->pluck('email')->first();
//        }
$accessControl = new AccessControl;
$accessControl ->checkSession();
$accessControl ->ensureEmployeeOrAdmin();
$controller = new BookController();
//$controller->checkLowStockAndSendEmail($email);
;?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <?php include 'Header.php'; ?>

        <div class="container py-5">
            <div class="row">
                <?php include 'ControlSidebar.php'; ?>

                <div class="col-lg-9">
                    <h1>Management Home</h1>
                    <div class="row">
                        Hi......
                    </div>
                </div>
            </div>
        </div>


        <?php include 'Footer.php'; ?>
    </body>
</html>
