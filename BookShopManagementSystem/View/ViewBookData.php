<?php
/** @author Bok Cheong Roy */

require_once __DIR__ . '/../config/bootstrap.php';  // Adjust path as needed
require_once '../Controller/BookController.php';

use BookShopManagementSystem\Controller\BookController;
use BookShopManagementSystem\Model\DescriptionDecorator;

$controller = new BookController();
if (isset($_GET['bookId'])) {
    $bookId = $_GET['bookId'];

    $book = $controller->getBookById($bookId);

    $descriptionDecorator = new DescriptionDecorator($book->description);
    $Description = $descriptionDecorator->getFormattedValue();
}
?>
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <?php include "Header.php" ?>

        <section class="bg-light">
            <div class="container pb-5">
                <div class="row">
                    <div class="col-lg-5 mt-5">
                        <?php if (isset($_GET['status']) && $_GET['status'] === 'success'): ?>
                            <div style="color: green; font-weight: bold;">
                                Book updated successfully!
                            </div>
                        <?php endif; ?>
                        <div class="card mb-3">
                            <img class="card-img img-fluid" src="<?php echo htmlspecialchars($book->image); ?>" alt="Card image cap" id="product-detail">
                        </div>
                    </div>

                    <div class="col-lg-7 mt-5">
                        <div class="card">
                            <!--                            <form action="../Controller/.php" method="POST">-->
                            <div class="card-body">
                                <h1 class="h2"><b><?php echo htmlspecialchars($book->bookName); ?></b> (<?php echo htmlspecialchars($book->bookId); ?>)</h1>
                                <input type="hidden" name="bookId" value="bookId">
                                <p class="h3 py-2">RM50.00</p>
                                <h6>Description:</h6>
                                <p><?php echo $Description; ?></p>
                                <h6>Author: </h6>
                                <p><?php echo htmlspecialchars($book->author); ?></p>
                                <h6>Category: </h6>
                                <p><?php echo htmlspecialchars($book->category); ?></p>
                                <!--                                    <h6>Language: </h6>
                                                                    <p>Languages</p>-->
                                <h6>Stock: </h6>
                                <p><?php echo htmlspecialchars($book->stock); ?></p>
                                <div class="row pb-3">
                                    <div class="col d-grid">
<!--                                            <input type="submit" class="btn btn-success btn-lg" name="button" value="Edit"><a href="UpdateBookData.php"></a>-->

                                        <button class="btn btn-success btn-lg" onclick="window.location.href = 'UpdateBookData.php?bookId=<?php echo htmlspecialchars($bookId); ?>'">Edit</button>
                                    </div>
                                    <div class="col d-grid">
<!--                                        <input type="submit" class="btn btn-success btn-lg" name="button" value="Delete">-->
                                        <form method="post" action="../Controller/BookController.php">
                                            <input type="hidden" name="bookId" value="<?php echo htmlspecialchars($bookId); ?>">
                                            <input type="hidden" name="action" value="deleteBook">
                                            <input type="submit" class="btn btn-danger btn-lg" name="button" value="Delete" onclick="return confirm('Are you sure you want to Delete this Book?')">
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <!--</form>-->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <?php include "Footer.php" ?>
</body>
</html>
