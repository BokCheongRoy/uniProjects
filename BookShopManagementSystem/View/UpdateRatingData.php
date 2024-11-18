<?php
/** @author Pua Jia Qian */
include_once '../Controller/ReviewController.php';
include_once '../Controller/FileManagement.php';
include_once '../Controller/SecureUrl.php';
require_once '../Controller/SessionManagement.php';
require_once '../Controller/AccessControl.php';

use BookShopManagementSystem\Controller\SessionManagement;
use BookShopManagementSystem\Controller\AccessControl;

SessionManagement::start();
$accessControl = new AccessControl;
$accessControl->checkSession();
$accessControl->ensureEmployeeOrAdmin();
$reviewController = new \BookShopManagementSystem\Controller\ReviewController();
$secureUrl = new SecureUrl();

if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['review_id'])) {
    $encryptedReviewId = $_GET['review_id'];
    $review_id = $secureUrl->decrypt($encryptedReviewId);

    if ($review_id === false) {
        echo "Invalid or corrupted review ID.";
        exit();
    }

    $review = $reviewController->readSingle($review_id);

    if (!$review) {
        echo "Review not found for ID: " . $review_id;
        exit();
    }
} elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $review_id = $_POST['review_id'];
    // Fetch the review details again to update it
    $review = $reviewController->readSingle($review_id);

    if (!$review) {
        echo "Review not found after form submission.";
        exit();
    }

    // Process form data for updating the review
    $orderId = $_POST['orderId'];
    $bookId = $_POST['bookId'];
    $rating = $_POST['rating'];
    $review_text = $_POST['review'];
    $comment = $_POST['comment'];
    $existing_photo = $_POST['existing_photo'];

    $photo = $existing_photo;
    if (isset($_FILES['photo']) && $_FILES['photo']['error'] == UPLOAD_ERR_OK) {
        $fileType = mime_content_type($_FILES['photo']['tmp_name']);
        $allowedTypes = ['image/jpeg', 'image/png', 'image/jpg'];

        if (!in_array($fileType, $allowedTypes)) {
            echo "<script>alert('Error: Only image files (JPEG, PNG, JPG) are allowed. Please re-upload.'); window.history.back();</script>";
            exit();
        }

        // Proceed with file upload
        try {
            $fileManager = new BookShopManagementSystem\Controller\FileManagement();
            $photo = $fileManager->uploadFile($_FILES['photo']);
        } catch (Exception $e) {
            echo "<script>alert('Error uploading file: " . $e->getMessage() . "'); window.history.back();</script>";
            exit();
        }
    } else {
        // Keep existing photo if no new file is uploaded
        $photo = $existing_photo;
    }


    if (strlen($comment) < 10 || strlen($comment) > 255) {
        echo "Comment must be between 10 and 255 characters.";
        exit();
    }
    $reviewData = [
        'review_id' => $review_id,
        'orderId' => $orderId,
        'bookId' => $bookId,
        'rating' => $rating,
        'review' => $review_text,
        'comment' => $comment,
        'photo' => $photo
    ];

    if ($reviewController->update($reviewData)) {
        echo "Review updated successfully!";
        header('Location: ViewRatingList.php');
        exit();
    } else {
        echo "Error: Failed to update the review.";
    }
} else {
    echo "Review ID not provided.";
    exit();
}
?>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Update Review</title>
    </head>
    <body>
        <?php include "Header.php"; ?>  

        <section class="bg-light">
            <div class="container pb-5">
                <div class="row">
                    <!-- Left Column: Photo Upload -->
                    <div class="col-lg-5 mt-5">
                        <form action="UpdateRatingData.php" method="post" enctype="multipart/form-data" onsubmit="return window.confirm('Confirm update?')">
                            <input type="hidden" name="review_id" value="<?php echo $review->review_id; ?>"> <!-- Use review_id consistently -->
                            <input type="hidden" name="orderId" value="<?php echo $review->orderId; ?>">

                            <div class="card mb-3">
                                <div class="card-header">
                                    <h5 class="text-center">Update Photo</h5>
                                </div>
                                <div class="card-body text-center">
                                    <!-- File input for updating the photo -->
                                    <input type="file" name="photo" class="form-control mb-3" accept=".jpg,.jpeg,.png">
                                    <img class="card-img img-fluid" src="<?php echo '../' . $review->photo; ?>" alt="Review Photo" id="photo-">
                                    <input type="hidden" name="existing_photo" value="<?php echo $review->photo; ?>">
                                </div>
                            </div>
                    </div>

                    <!-- Right Column: Review Form Fields -->
                    <div class="col-lg-7 mt-5">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="text-center">Update Review</h5>
                            </div>
                            <div class="card-body">
                                <h6>Book ID:</h6>
                                <p><input style="width:100%;" type="text" name="bookId" value="<?php echo $review->bookId; ?>" readonly></p>
                                <h6>Review ID:</h6>
                                <p><input style="width:100%;" type="text" name="review_id" value="<?php echo $review->review_id; ?>" readonly></p>

                                <h6>Rating:</h6>
                                <p><input style="width:100%;" type="number" name="rating" value="<?php echo $review->rating; ?>" required min="1" max="5" step="1" title="Rating between 1-5"></p>

                                <h6>Review:</h6>
                                <p><textarea style="width:100%;" name="review" rows="3" minlength="10" max-length="255" required><?php echo htmlspecialchars($review->review); ?></textarea></p>

                                <h6>Comment:</h6>
                                <p><textarea style="width:100%;" name="comment" rows="3" minlength="10" max-length="255" required><?php echo!empty($review->comment) ? htmlspecialchars($review->comment) : "No comments"; ?></textarea></p>

                                <div class="row pb-3">
                                    <div class="col d-grid">
                                        <input type="submit" class="btn btn-success btn-lg" value="Update">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    </form> 
                </div>
            </div>
        </section>

        <?php include "Footer.php"; ?>
    </body>
</html>
