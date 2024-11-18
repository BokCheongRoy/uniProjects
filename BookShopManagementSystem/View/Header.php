<?php
/** @author All members */

require_once '../Controller/SessionManagement.php';
require_once '../Controller/CartController.php'; // Ensure this is included at the top
use BookShopManagementSystem\Controller\CartController;
use BookShopManagementSystem\Controller\SessionManagement;

if (isset($_SESSION['custId'])) {
    $custId = $_SESSION['custId']; 
    $cartController = new CartController();
    $cartItemCount = $cartController->getCartItemCount($custId);
}

SessionManagement::start();
$sessionManagement = new SessionManagement();
$sessionManagement->checkSessionTimeout(900);

$custId = $_SESSION['custId'] ?? null;
$empId = $_SESSION['empId'] ?? null;
$adminId = $_SESSION['adminId'] ?? null;
?>

<!DOCTYPE html>
<html>
    <head>
        <title>BQY Book Shop</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" href="../assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="../assets/css/templatemo.css">
        <link rel="stylesheet" href="../assets/css/custom.css">

        <!-- Load fonts style after rendering the layout styles -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
        <link rel="stylesheet" href="../assets/css/fontawesome.min.css">

        <!-- Load map styles -->
        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" integrity="sha512-xodZBNTC5n17Xt2atTPuE1HxjVMSvLVW9ocqUKLsCC5CXdbqCmblAshOMAS6/keqq/sMZMZ19scR4PsZChSR7A==" crossorigin="" />
    </head>

    <body>
        <!-- Start Top Nav -->
        <nav class="navbar navbar-expand-lg bg-dark navbar-light d-none d-lg-block" id="templatemo_nav_top">
            <div class="container text-light">
                <div class="w-100 d-flex justify-content-between">
                    <div>
                        <i class="fa fa-envelope mx-2"></i>
                        <a class="navbar-sm-brand text-light text-decoration-none" href="mailto:bqy_bookshop@gmail.com">bqy_bookshop@gmail.com</a>
                        <i class="fa fa-phone mx-2"></i>
                        <a class="navbar-sm-brand text-light text-decoration-none" href="tel:013-3201802">013-3201802</a>
                    </div>
                    <div>
                        <a class="text-light" href="https://fb.com" target="_blank" rel="sponsored"><i class="fab fa-facebook-f fa-sm fa-fw me-2"></i></a>
                        <a class="text-light" href="https://www.instagram.com/" target="_blank"><i class="fab fa-instagram fa-sm fa-fw me-2"></i></a>
                        <a class="text-light" href="https://twitter.com/" target="_blank"><i class="fab fa-twitter fa-sm fa-fw me-2"></i></a>
                    </div>
                </div>
            </div>
        </nav>
        <!-- Close Top Nav -->
        <?php if ($empId || $adminId): ?>
            <nav class="navbar navbar-expand-lg navbar-light shadow">
                <div class="container d-flex justify-content-between align-items-center">
                    <img class="img-fluid" src="../BookImage/bookCover.png" width="50" height="50" alt="">
                    <a class="navbar-brand text-success logo h1 align-self-center" href="../View/ManagementHome.php">BQY Book Shop</a>
                <?php else: ?>
                    <!-- Header -->
                    <nav class="navbar navbar-expand-lg navbar-light shadow">
                        <div class="container d-flex justify-content-between align-items-center">
                            <img class="img-fluid" src="../BookImage/bookCover.png" width="50" height="50" alt="">
                            <a class="navbar-brand text-success logo h1 align-self-center" href="../View/Home.php">BQY Book Shop</a>

                            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#templatemo_main_nav" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                                <span class="navbar-toggler-icon"></span>
                            </button>

                            <div class="align-self-center collapse navbar-collapse flex-fill  d-lg-flex justify-content-lg-between" id="templatemo_main_nav">
                                <div class="flex-fill">
                                    <ul class="nav navbar-nav d-flex mx-lg-auto">
                                        <li class="nav-item"><a class="nav-link" href="Home.php">Home</a></li>
                                        <li class="nav-item"><a class="nav-link" href="ViewBook.php">Books</a></li>

                                    </ul>
                                </div>
                            <?php endif; ?>
                            <?php if ($custId): ?>
                                <div class="navbar align-self-center d-flex">
                                    <a class="nav-icon position-relative text-decoration-none" href="../View/ViewCart.php">
                                        <i class="fa fa-fw fa-cart-arrow-down text-dark mr-1"></i>
                                        <?php if ($cartItemCount > 0): ?>
                                            <span class="position-absolute top-0 left-100 translate-middle badge rounded-pill bg-danger text-dark">
                                                <?php echo htmlspecialchars($cartItemCount); ?>
                                            </span>
                                        <?php endif; ?>
                                    </a>
                                <?php endif; ?>
                                <?php if ($custId): ?>
                                    <a class="nav-icon position-relative text-decoration-none" href="../View/ViewWishlist.php">
                                        <i class="fa fa-fw fa-heart text-dark mr-3"></i>
                                        <span class="position-absolute top-0 left-100 translate-middle badge rounded-pill bg-light text-dark"></span>
                                    </a>
                                <?php endif; ?>
                                <?php if ($custId): ?>
                                    <a class="nav-icon position-relative text-decoration-none" href="../View/ViewProfile.php">
                                        <i class="fa fa-fw fa-user text-dark mr-3"></i>
                                        <span class="position-absolute top-0 left-100 translate-middle badge rounded-pill bg-light text-dark"></span>
                                    </a>
                                <?php endif; ?>
                                <?php if ($empId || $adminId): ?>
                                    <a class="nav-icon position-relative text-decoration-none" href="../View/ViewEmployeeProfile.php">
                                        <i class="fa fa-fw fa-user text-dark mr-3"></i>
                                        <span class="position-absolute top-0 left-100 translate-middle badge rounded-pill bg-light text-dark"></span>
                                    </a>




                                <?php endif; ?>
                                <?php if ($custId || $empId || $adminId): ?>
                                    <!-- Add extra margin here for spacing -->
                                    <span style="margin-right: 10px;"></span> <!-- This adds spacing -->

                                    <a class="nav-icon position-relative text-decoration-none" href="../Controller/logout_action.php">
                                        <i class="fa fa-fw fa-sign-out-alt text-dark mr-3"></i>
                                        <span class="position-absolute top-0 left-100 translate-middle badge rounded-pill bg-light text-dark">Logout</span>
                                    </a>

                                <?php else: ?>
                                    <a class="nav-icon position-relative text-decoration-none" href="Login.php">
                                        <i class="fa fa-fw fa-sign-in-alt text-dark mr-3"></i>
                                        <span class="position-absolute top-0 left-100 translate-middle badge rounded-pill bg-light text-dark">Login Now</span>
                                    </a>
                                <?php endif; ?>
                            </div>
                        </div>
                    </div>
                </nav>
                </body>
                </html>
