<?php
/** @author Pua Jia Qian */

require_once __DIR__ . '/../Controller/ReviewController.php';
require_once __DIR__ . '/../config/bootstrap.php';
include_once '../Controller/SecureUrl.php';
require_once '../Controller/SessionManagement.php';
require_once '../Controller/AccessControl.php';

use BookShopManagementSystem\Controller\SessionManagement;
use BookShopManagementSystem\Controller\AccessControl;

SessionManagement::start();
$accessControl = new AccessControl;
$accessControl ->checkSession();
$accessControl ->ensureEmployeeOrAdmin();
$reviewController = new \BookShopManagementSystem\Controller\ReviewController();
$secureUrl = new SecureUrl(); 

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['action']) && $_POST['action'] === 'delete') {
        $review_id = $_POST['review_id']; // Fetch the review_id from POST data

        if ($reviewController->delete($review_id)) {
            header('Location: ViewRatingList.php'); 
            exit();
        } else {
            echo "Error: Failed to delete the review.";
            exit();
        }
    }
}

if (isset($_GET['review_id'])) {
    $encryptedReviewId = $_GET['review_id'];
    $review_id = $secureUrl->decrypt($encryptedReviewId); 

    if ($review_id === false) {
        echo "Invalid or corrupted review ID.";
        exit();
    }

    // Fetch the review details using the decrypted review_id
    $review = $reviewController->readSingle($review_id);

    if (!$review) {
        echo "Review not found.";
        exit();
    }
} else {
    echo "Review not found.";
    exit();
}
?>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>View Review Data</title>
    </head>
    <body>
        <?php include "Header.php"; ?>

        <section class="bg-light">
            <div class="container pb-5">
                <div class="row">
                    <div class="col-lg-5 mt-5">
                        <div class="card mb-3">
                            <img class="card-img img-fluid"  src="<?php echo '../' . $review['photo']; ?>" alt="Book image" id="product-detail">
                        </div>
                    </div>

                    <div class="col-lg-7 mt-5">
                        <div class="card">
                            <form action="ViewRatingData.php" method="GET">
                                <div class="card-body">
                                    <h1 class="h2">
                                        <b><?php echo $review['bookId']; ?></b> (<?= htmlspecialchars($review_id) ?>)
                                    </h1>
                                    <input type="hidden" name="review_id" value="<?= htmlspecialchars($review_id) ?>">
                                    <p class="h3 py-2"><?php echo $review->book->bookName; ?></p>
                                    <h6>Order: </h6>
                                    <p><?php echo $review['orderId']; ?></p>
                                    <h6>Rating: </h6>
                                    <p><?php echo $review['rating']; ?></p>
                                    <h6>Review: </h6>
                                    <p><?php echo $review['review']; ?></p>
                                    <h6>Review Date: </h6>
                                    <p><?php echo $review['review_date']; ?></p>
                                    <h6>Comment: </h6>
                                    <p><?php echo!empty($review['comment']) ? htmlspecialchars($review['comment']) : "No comments"; ?></p>

                                    <!-- Update and Delete buttons -->
                                    <div class="row pb-3">
                                        <div class="col d-grid">
                                            <?php
                                            $encryptedReviewId = $secureUrl->encrypt($review['review_id']);
                                            ?>
                                            <a href="UpdateRatingData.php?review_id=<?php echo urlencode($encryptedReviewId); ?>" class="btn btn-success btn-lg">Update</a>
                                        </div>
                                        </form>

                                        <div class="col d-grid">
                                            <form action="ViewRatingData.php" method="POST" onsubmit="return window.confirm('Are you sure you want to delete this review?');">
                                                <input type="hidden" name="review_id" value="<?php echo $review['review_id']; ?>"> 
                                                <input type="hidden" name="action" value="delete">
                                                <button type="submit" class="btn btn-danger btn-lg" style="width:300px;">Delete</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <?php include "Footer.php"; ?>
    </body>
</html>
