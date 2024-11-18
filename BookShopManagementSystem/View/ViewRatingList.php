<?php
/** @author Pua Jia Qian */

include_once '../Controller/ReviewController.php';
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

$filter = isset($_GET['selectRating']) && $_GET['selectRating'] != 'all' ? $_GET['selectRating'] : null;
$sortBy = isset($_GET['sortBy']) ? $_GET['sortBy'] : 'review_id';
$sortOrder = isset($_GET['sortOrder']) ? $_GET['sortOrder'] : 'asc';

// Pass the filter and sorting options to the controller
$reviews = $reviewController->read($filter, $sortBy, $sortOrder);
?>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>View Rating List</title>
        <style>
            .filter-container {
                display: flex;
                justify-content: flex-end;
                margin-bottom: 20px;
                margin-right: 20px;
            }

            .filter-container select,
            .filter-container input[type="submit"] {
                margin-left: 10px;
                padding: 8px 12px;
                font-size: 15px;
            }
        </style>
    </head>
    <body>

        <?php include 'Header.php'; ?>

        <div class="container py-5">
            <div class="row">
                <?php include 'ControlSidebar.php'; ?>
                <div class="col-lg-9">
                    <h1>View Rating List</h1>
                    <div class="filter-container">
                        <form action="ViewRatingList.php" method="GET">
                            <select name="selectRating">
                                <option value="all">All Ratings</option>
                                <option value="1-star" <?php echo isset($_GET['selectRating']) && $_GET['selectRating'] == '1-star' ? 'selected' : ''; ?>>1 star</option>
                                <option value="2-star" <?php echo isset($_GET['selectRating']) && $_GET['selectRating'] == '2-star' ? 'selected' : ''; ?>>2 stars</option>
                                <option value="3-star" <?php echo isset($_GET['selectRating']) && $_GET['selectRating'] == '3-star' ? 'selected' : ''; ?>>3 stars</option>
                                <option value="4-star" <?php echo isset($_GET['selectRating']) && $_GET['selectRating'] == '4-star' ? 'selected' : ''; ?>>4 stars</option>
                                <option value="5-star" <?php echo isset($_GET['selectRating']) && $_GET['selectRating'] == '5-star' ? 'selected' : ''; ?>>5 stars</option>
                            </select>
                            <select name="sortBy">
                                <option value="review_id" <?php echo isset($_GET['sortBy']) && $_GET['sortBy'] == 'review_id' ? 'selected' : ''; ?>>Sort by Review ID</option>
                                <option value="rating" <?php echo isset($_GET['sortBy']) && $_GET['sortBy'] == 'rating' ? 'selected' : ''; ?>>Sort by Rating</option>
                                <option value="review_date" <?php echo isset($_GET['sortBy']) && $_GET['sortBy'] == 'review_date' ? 'selected' : ''; ?>>Sort by Date</option>
                            </select>
                            <select name="sortOrder">
                                <option value="asc" <?php echo isset($_GET['sortOrder']) && $_GET['sortOrder'] == 'asc' ? 'selected' : ''; ?>>Ascending</option>
                                <option value="desc" <?php echo isset($_GET['sortOrder']) && $_GET['sortOrder'] == 'desc' ? 'selected' : ''; ?>>Descending</option>
                            </select>
                            <input type="submit" class="btn btn-primary mr-2" name="filter" value="Filter">
                        </form>
                    </div>

                    <table style='font-size: 15px; margin:20px; padding:20px; border: 1px dashed green;'>
                        <tr align="center" style='margin:20px; border: 1px dashed green;'>
                            <th style="width:8%">ID</th>
                            <th colspan='2' style="width:20%">Order</th>
                            <th style="width:8%">Book</th>
                            <th style="width:8%">Rating</th>
                            <th style="width:17%">Review</th>
                            <th style="width:10%">Date</th>
                            <th style="width:17%">Comment</th>
                            <th style="width:20%">Action</th>
                        </tr>
                        <?php
                        if ($reviews->isNotEmpty()) {
                            foreach ($reviews as $review) {
                                // Encrypt the review_id before generating the link
                                $encryptedReviewId = $secureUrl->encrypt($review['review_id']);
                                ?>
                                <tr align="center" style='border: 1px dashed green;'>
                                    <td><?php echo $review['review_id']; ?></td>
                                    <td>
                                        <img src="<?php echo '../' . $review['photo']; ?>" style="width:50px; height:60px;" alt="Review Image">
                                    </td>
                                    <td><?php echo $review['orderId']; ?></td>
                                    <td><?php echo $review['bookId']; ?></td>
                                    <td><?php echo $review['rating']; ?></td>
                                    <td><?php echo $review['review']; ?></td>                                    
                                    <td><?php echo date('Y-m-d', strtotime($review['review_date'])); ?></td>
                                    <td><?php echo!empty($review['comment']) ? htmlspecialchars($review['comment']) : "No comments"; ?></td>
                                    <td>
                                        <a href="ViewRatingData.php?review_id=<?php echo $encryptedReviewId; ?>" class="btn btn-success btn-lg">View</a>
                                    </td>
                                </tr>
                                <?php
                            }
                        } else {
                            ?>
                            <tr>
                                <td colspan="9" align="center">No reviews found</td>
                            </tr>
                            <?php
                        }
                        ?>
                    </table>
                </div>
            </div>
        </div>

        <?php include 'Footer.php'; ?>

    </body>
</html>
