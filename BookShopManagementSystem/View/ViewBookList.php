<?php
/** @author Bok Cheong Roy */

require_once __DIR__ . '/../config/bootstrap.php';  // Adjust path as needed
require_once '../Controller/BookController.php';
require_once '../Controller/SessionManagement.php';
require_once '../Controller/AccessControl.php';

use BookShopManagementSystem\Controller\BookController;
use BookShopManagementSystem\Controller\SessionManagement;
use BookShopManagementSystem\Controller\AccessControl;

SessionManagement::start();
$accessControl = new AccessControl;
$accessControl->checkSession();
$accessControl->ensureEmployeeOrAdmin();

$controller = new BookController();
if (isset($_GET['searchTerm'])) {
    $searchTerm = $_GET['searchTerm'];
    $books = $controller->searchBooksAdmin($searchTerm);
} else {
    // Fetch all books if no search term is provided
    $books = $controller->listNotDeletedBooks();
}
?>

<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/Scripting/EmptyPHPWebPage.php to edit this template
-->
<html>
    <head>
        <meta charset="UTF-8">
        <title>BQY Book List</title>
    </head>
    <body>
<?php include "Header.php" ?>  

        <div class="container py-5">
            <div class="row">
<?php include 'ControlSidebar.php'; ?>

                <div class="col-lg-9">
                    <h1>Book List</h1>
                    <div class="row">
<?php if (isset($_GET['status']) && $_GET['status'] === 'deleted'): ?>
                            <div style="color: red; font-weight: bold;">
                                Book deleted successfully!
                            </div>
<?php endif; ?>
                        <form action="" method="get">
                            <input type="text" name="searchTerm" placeholder="Search Books...">
                            <button type="submit" class="btn btn-success">Search</button>
                            <a href="ViewBookList.php" class="btn btn-secondary ml-2">Clear</a>
                        </form>
                        <table style='font-size: 15px;margin:20px;padding:20px; border: 1px dashed green;'>
                            <tr align="center" style='margin:20px;border: 1px dashed green;'>
                                <th style="width:5%">ID</th>
                                <th colspan='2' style="width:30%">Name</th>
                                <th style="width:10%">Author</th>
                                <th style="width:10%">Stocks</th>
                                <th style="width:10%">Price</th>
                                <th style="width:10%">Category</th>
                                <th style="width:10%">Status</th>
                                <th style="width:10%">Action</th>
                            </tr>
<?php foreach ($books as $book): ?>
                                <tr align="center" style='border: 1px dashed green;'>
                                    <td><?php echo htmlspecialchars($book->bookId); ?></td>
                                    <td><img src="<?php echo htmlspecialchars($book->image); ?>" style="weight:50px; height:60px;"></td>
                                    <td><?php echo htmlspecialchars($book->bookName); ?></td>
                                    <td><?php echo htmlspecialchars($book->author); ?></td>
                                    <td><?php echo htmlspecialchars($book->stock); ?></td>
                                    <td>RM<?php echo htmlspecialchars($book->price); ?></td>
                                    <td><?php echo htmlspecialchars($book->category); ?></td>
                                    <td><?php echo htmlspecialchars($book->status); ?></td>
                                    <td>
                                        <!--                                <form action="ViewBookData.php" method="post">
                                                                            <input type="hidden" name="bookId" value="bookId">
                                                                            <input class="btn btn-success btn-lg" type="submit" value="View">
                                                                        </form>-->
                                        <button class="btn btn-success btn-lg" onclick="window.location.href = 'ViewBookData.php?bookId=<?php echo htmlspecialchars($book->bookId); ?>'">View</button>

                                    </td>
                                </tr>
<?php endforeach; ?>
                        </table>
                    </div>
                </div>
            </div>
        </div>

<?php include "Footer.php" ?>
    </body>
</html>
