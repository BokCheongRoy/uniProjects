<?php
/** @author Lee Weng Yi */

require_once '../Controller/OrderController.php';
require_once __DIR__ . '/../config/bootstrap.php';
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

if (isset($_POST['orderId']) && !empty($_POST['orderId'])) {
    $orderId = $_POST['orderId'];
} elseif (isset($_GET['orderId']) && !empty($_GET['orderId'])) {
    $orderId = $_GET['orderId'];
} else {
    header('Location: ../View/ViewOrderList.php');
    exit;
}

$orderDetails = $orderController->getOrderDetails($orderId);
$orderInfo = $orderController->getOrderById($orderId);
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Details</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .order-table {
            font-size: 15px;
            margin: 20px;
            padding: 20px;
            border: 1px solid green;
        }
        .order-table th, .order-table td {
            border: 1px solid green;
        }
    </style>
</head>
<body>
    <?php include 'Header.php'; ?>
    <div class="container py-5">
        <div class="row">
            <?php include 'ControlSidebar.php'; ?>
            <div class="col-lg-9">
                <h1>Order Details (<?php echo htmlspecialchars($orderId); ?>)</h1>

                <?php if (isset($_SESSION['error_message'])): ?>
                <div class="alert alert-danger">
                    <?php
                    echo htmlspecialchars($_SESSION['error_message']);
                    unset($_SESSION['error_message']);
                    ?>
                </div>
                <?php endif; ?>
                <?php if (isset($_SESSION['success_message'])): ?>
                <div class="alert alert-success">
                    <?php
                    echo htmlspecialchars($_SESSION['success_message']);
                    unset($_SESSION['success_message']);
                    ?>
                </div>
                <?php endif; ?>
                
                <div class="row">
                    <form action="../Controller/OrderController.php" method="post">
                        <input type="hidden" name="orderId" value="<?php echo htmlspecialchars($orderId); ?>">
                        <table class="table order-table">
                            <thead class="thead-light">
                                <tr>
                                    <th>Book ID</th>
                                    <th>Image</th>
                                    <th>Book Name</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($orderDetails as $detail) { ?>
                                    <tr align="center">
                                        <td><?php echo htmlspecialchars($detail->book->bookId); ?></td>
                                        <td><img src="<?php echo htmlspecialchars($detail->book->image); ?>" style="width:50px; height:60px;" alt="Book Image"></td>
                                        <td><?php echo htmlspecialchars($detail->book->bookName); ?></td>
                                        <td><?php echo htmlspecialchars($detail->quantity); ?></td>
                                        <td><?php echo htmlspecialchars($detail->book->price); ?></td>
                                    </tr>
                                <?php } ?>
                                <tr>
                                    <td>Receiver:</td>
                                    <td colspan="4"><?php echo htmlspecialchars($orderInfo['recipientName']); ?></td>
                                </tr>
                                <tr>
                                    <td>Address:</td>
                                    <td colspan="4"><?php echo htmlspecialchars($orderInfo['address']); ?></td>
                                </tr>
                                <tr>
                                    <td>Status:</td>
                                    <td colspan="4"><?php echo htmlspecialchars($orderInfo['status']); ?></td>
                                </tr>
                            </tbody>
                        </table>

                        <div class="row pb-3">
                            <input type="hidden" name="action" value="updateStatus">
                            
                            <?php if ($orderInfo['status'] !== 'Accepted' && $orderInfo['status'] !== 'Shipping' && $orderInfo['status'] !== 'Delivered'): ?>
                                <div class="col d-grid">
                                    <input type="submit" class="btn btn-success btn-lg" name="accepted" value="Accept">
                                </div>
                            <?php endif; ?>
                            
                            <?php if ($orderInfo['status'] === 'Accepted'): ?>
                                <div class="col d-grid">
                                    <input type="submit" class="btn btn-success btn-lg" name="shipping" value="Ship">
                                </div>
                            <?php endif; ?>
                            
                            <?php if ($orderInfo['status'] === 'Shipping'): ?>
                                <div class="col d-grid">
                                    <input type="submit" class="btn btn-success btn-lg" name="delivered" value="Deliver">
                                </div>
                            <?php endif; ?>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <?php include 'Footer.php'; ?>
</body>
</html>
