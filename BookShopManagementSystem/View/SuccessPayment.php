<?php
/** @author Lee Weng Yi*/

use BookShopManagementSystem\Controller\SessionManagement;
use BookShopManagementSystem\Controller\AccessControl;

require_once '../Controller/SessionManagement.php';
require_once '../Controller/AccessControl.php';

SessionManagement::start();
$accessControl = new AccessControl;
$accessControl ->checkSession();
$accessControl ->ensureCustomer();
?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BQY Success Payment</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .card-success {
                max-width: 600px;
                margin: 50px auto;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
        </style>
    </head>
    <body>
        <?php include 'Header.php'; ?>

        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card card-success text-center">
                        <div class="card-body">
                            <h3 class="text-success mb-4">Payment Successful!</h3>
                            <p class="lead mb-4">Thank you for purchasing from BQY Bookstore.</p>
                            <p>We hope you enjoy reading your new book!</p>
                            <a class="btn btn-success" href="ViewOrderHistory.php">View Order History</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <?php include 'Footer.php'; ?>
    </body>
</html>
