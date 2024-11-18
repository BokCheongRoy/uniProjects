<?php
/** @author Bok Cheong Roy */

use BookShopManagementSystem\Controller\BookController;

require_once __DIR__ . '/../config/bootstrap.php';  // Adjust path as needed
require_once '../Controller/BookController.php';

$controller = new BookController();

$book = null;
if (isset($_GET['bookId'])) {
    $bookId = $_GET['bookId'];
    $book = $controller->getBookById($bookId);

    // Fetch the authors (assuming authors are stored in a string, separated by commas)
    $authors = explode(',', $book->author);  // Adjust this line if your storage format is different
} else {
    $authors = [];
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Book</title>
</head>
<body>
    <?php include "Header.php"; ?>  

    <section class="bg-light">
         <form id="bookForm" action="../Controller/BookController.php" method="post" enctype="multipart/form-data" onsubmit="return validateAuthors() && window.confirm('Confirm update?')">
        <div class="container pb-5">
            <div class="row">
                <div class="col-lg-5 mt-5">
                        <div class="card mb-3">
                            <input type="file" name="bookImage" value="">
                            <img class="card-img img-fluid" src="<?php echo htmlspecialchars($book->image);?>" alt="Book Image" id="bookImg">
                        </div>
                </div>
                <div class="col-lg-7 mt-5">
                    <div class="card">
                        <div class="card-body">
                            <h6>Book ID: </h6>
                            <p><input style="width:100%;" type="text" name="bookId" value="<?php echo htmlspecialchars($book->bookId); ?>" readonly></p>

                            <h6>Book Name: </h6>
                            <p><input style="width:100%;" type="text" name="bookName" value="<?php echo htmlspecialchars($book->bookName); ?>" required></p>

                            <h6>Description:</h6>
                            <p><input style="width:100%;" type="text" name="bookDescription" value="<?php echo htmlspecialchars($book->description); ?>" required></p>

                            <h6>Authors: </h6>
                            <div id="authorFields">
                                <!-- JavaScript will dynamically populate author fields here -->
                            </div>
                            <button type="button" onclick="addAuthorField()">Add Another Author</button><br><br>

                            <h6>Price: </h6>
                            <p><input style="width:100%;" type="text" name="bookPrice" value="<?php echo htmlspecialchars($book->price); ?>" 
                                      pattern="[0-9]+(\.[0-9]{1,2})?" title="Please enter format as 0.00"  required></p>

                            <h6>Stock: </h6>
                            <p><input style="width:100%;" type="text" name="bookStock" value="<?php echo htmlspecialchars($book->stock); ?>" 
                                      pattern="[0-9]+" title="Please enter number" required></p>

                            <h6>Category: </h6>
                            <p><input style="width:100%;" type="text" name="bookCategory" value="<?php echo htmlspecialchars($book->category); ?>" 
                                      pattern="[a-zA-Z]+" title="Please enter only letters" required></p>

                            <!-- New Dropdown for Book Status -->
                            <h6>Status: </h6>
                            <p>
                                <select name="bookStatus" required>
                                    <option value="Available" <?php echo ($book->status === 'Available') ? 'selected' : ''; ?>>Available</option>
                                    <option value="Disable" <?php echo ($book->status === 'Disable') ? 'selected' : ''; ?>>Disable</option>
                                </select>
                            </p>

                            <div class="row pb-3">
                                <div class="col d-grid">
                                    <input type="submit" class="btn btn-success btn-lg" name="action" value="updateBook" onclick="return confirm('Are you sure you want to Update this Book?')">
                                </div>
                            </div>
                        </div>
                    </div>                            
                </div>
            </div>
        </div>
        </form>
    </section>

    <?php include "Footer.php"; ?>  

    <script>
        // Initialize the authors array from PHP
        let authors = <?php echo json_encode($authors); ?>;

        function addAuthorField(author = '') {
            const authorFields = document.getElementById("authorFields");

            // Create a wrapper div to hold the input and remove button together
            const authorDiv = document.createElement("div");
            authorDiv.style.marginBottom = "10px";

            // Create the input field
            const newField = document.createElement("input");
            newField.type = "text";
            newField.name = "bookAuthor[]"; // Make it an array to handle multiple authors
            newField.placeholder = "Enter author";
            newField.style.width = "80%";
            newField.value = author;  // Set the value if provided
            newField.required = true;

            // Create the remove button
            const removeButton = document.createElement("button");
            removeButton.type = "button";
            removeButton.innerHTML = "Remove";
            removeButton.style.marginLeft = "10px";
            removeButton.onclick = function() {
                // Ensure that at least one author field remains
                if (authorFields.children.length > 1) {
                    authorFields.removeChild(authorDiv); // Remove the parent div of the input
                } else {
                    alert('At least one author field must remain.');
                }
            };

            // Append the input and button to the div, then append the div to the authorFields container
            authorDiv.appendChild(newField);
            authorDiv.appendChild(removeButton);

            // Check if this is the first author field
            if (authorFields.children.length === 0) {
                // The first author field should not have a remove button
                removeButton.style.display = 'none';
            }

            authorFields.appendChild(authorDiv);
        }

        // Ensure at least one author field is present on page load
        if (authors.length === 0) {
            addAuthorField(); // Add one author field if none are present
        } else {
            authors.forEach(author => addAuthorField(author));
        }
    </script>
</body>
</html>
