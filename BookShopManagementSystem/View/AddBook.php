<?php
/** @author Bok Cheong Roy */

use BookShopManagementSystem\Controller\SessionManagement;
use BookShopManagementSystem\Controller\AccessControl;
require_once '../Controller/SessionManagement.php';
require_once '../Controller/AccessControl.php';
SessionManagement::start();
$accessControl = new AccessControl;
$accessControl ->checkSession();
$accessControl -> ensureAdmin();

?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>BQY Add Book</title>
        <script>
            // Function to dynamically add author fields
            function addAuthorField() {
                const authorFields = document.getElementById("authorFields");

                // Create a wrapper div to hold the input and remove button together
                const authorDiv = document.createElement("div");
                authorDiv.style.marginBottom = "10px";

                // Create the input field
                const newField = document.createElement("input");
                newField.type = "text";
                newField.name = "bookAuthor[]"; // Make it an array to handle multiple authors
                newField.placeholder = "Enter another author";
                newField.style.width = "80%";
                newField.required = true; // Make the new input field required

                // Create the remove button
                const removeButton = document.createElement("button");
                removeButton.type = "button";
                removeButton.innerHTML = "Remove";
                removeButton.style.marginLeft = "10px";
                removeButton.onclick = function() {
                    authorFields.removeChild(authorDiv); // Remove the parent div of the input
                };

                // Append the input and button to the div, then append the div to the authorFields container
                authorDiv.appendChild(newField);
                authorDiv.appendChild(removeButton);
                authorFields.appendChild(authorDiv);
            }
        </script>
    </head>
    <body>
        <?php include "Header.php"; ?>  

        <div class="container py-5">
            <div class="row">
                <?php include 'ControlSidebar.php'; ?>

                <div class="col-lg-9">
                    <h1>Add Book</h1>
                    <?php if (isset($_GET['status']) && $_GET['status'] === 'success'): ?>
                        <div style="color: green; font-weight: bold;">
                            Book added successfully!
                        </div>
                    <?php endif; ?>
                    <div class="row">
                        <form action="../Controller/BookController.php" method="post" enctype="multipart/form-data">
                            <h6>Book Image: </h6>
                            <p><input style="width:100%;" type="file" name="bookImage" accept=".jpg,.jpeg,.png" required></p>

                            <h6>Book Name: </h6>
                            <p><input style="width:100%;" type="text" name="bookName" required></p>

                            <h6>Authors: </h6>
                            <div id="authorFields">
                                <!-- First author field, cannot be removed -->
                                <div style="margin-bottom: 10px;">
                                    <input style="width:80%;" type="text" name="bookAuthor[]" placeholder="Enter author" required>
                                </div>
                            </div>
                            <button type="button" onclick="addAuthorField()">Add Another Author</button><br><br>

                            <h6>Price: </h6>
                            <p><input style="width:100%;" type="text" name="bookPrice" pattern="[0-9]+(\.[0-9]{1,2})?" placeholder="Please enter format as 0.00" required></p>

                            <h6>Stock: </h6>
                            <p><input style="width:100%;" type="text" name="bookStock" pattern="[0-9]+" placeholder="Please enter number" required></p>

                            <h6>Category: </h6>
                            <p><input style="width:100%;" type="text" name="bookCategory" pattern="[a-zA-Z]+" placeholder="Please enter only letters" required></p>

                            <h6>Description:</h6>
                            <p><input style="width:100%;" type="text" name="bookDescription" required></p>

                            <div class="row pb-3">
                                <div class="col d-grid">
<!--                                    <input type="hidden" name="action" value="addBook">-->
                                    <input type="submit" class="btn btn-success btn-lg" name="action" value="addBook" onclick="return confirm('Are you sure you want to Add this Book?')">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <?php include "Footer.php"; ?>
    </body>
</html>
