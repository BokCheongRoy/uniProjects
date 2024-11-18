<?php
/** @author Choo Shi Yi*/

use BookShopManagementSystem\Controller\SessionManagement;
use BookShopManagementSystem\Controller\AccessControl;
require_once '../Controller/SessionManagement.php';
require_once '../Controller/AccessControl.php';
SessionManagement::start();
$accessControl = new AccessControl;
$accessControl ->checkSession();
$accessControl ->ensureAdmin();

use BookShopManagementSystem\Controller\CustomerController;

require_once '../config/bootstrap.php';
require_once '../Controller/CustomerController.php';

$customerController = new CustomerController();

// Get the selected month from the dropdown, default to null if not set
$selectedMonth = $_GET['month'] ?? null;

// Generate XML report
$customerController->generateUserXMLReport($selectedMonth);

?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Registration Report</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            width: 80%;
            margin: auto;
            overflow: hidden;
        }
        h2 {
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
           background-color:#C0C0C0;
            color: black;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        select {
            padding: 8px;
            border-radius: 4px;
            border: 1px solid #ddd;
        }
        form {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <?php include "Header.php"; ?>

    <div class="container py-5">
        <div class="row">
            <?php include 'ControlSidebar.php'; ?>

            <div class="col-lg-9">
                <form method="get" action="">
                    <label for="month">Filter by Month:</label>
                    <select id="month" name="month" onchange="this.form.submit()">
                        <option value="">--Select Month--</option>
                        <option value="01" <?= $selectedMonth == '01' ? 'selected' : '' ?>>January</option>
                        <option value="02" <?= $selectedMonth == '02' ? 'selected' : '' ?>>February</option>
                        <option value="03" <?= $selectedMonth == '03' ? 'selected' : '' ?>>March</option>
                        <option value="04" <?= $selectedMonth == '04' ? 'selected' : '' ?>>April</option>
                        <option value="05" <?= $selectedMonth == '05' ? 'selected' : '' ?>>May</option>
                        <option value="06" <?= $selectedMonth == '06' ? 'selected' : '' ?>>June</option>
                        <option value="07" <?= $selectedMonth == '07' ? 'selected' : '' ?>>July</option>
                        <option value="08" <?= $selectedMonth == '08' ? 'selected' : '' ?>>August</option>
                        <option value="09" <?= $selectedMonth == '09' ? 'selected' : '' ?>>September</option>
                        <option value="10" <?= $selectedMonth == '10' ? 'selected' : '' ?>>October</option>
                        <option value="11" <?= $selectedMonth == '11' ? 'selected' : '' ?>>November</option>
                        <option value="12" <?= $selectedMonth == '12' ? 'selected' : '' ?>>December</option>
                    </select>
                </form>

                <?php echo $customerController->displayUserSummary($selectedMonth); ?>
            </div>
        </div>
    </div>

    <?php include "Footer.php"; ?>
</body>
</html>
