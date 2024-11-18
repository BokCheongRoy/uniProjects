<?php 
/** @author Choo Shi Yi */
?>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.4/dist/sweetalert2.min.css">
        <title>Reset Password</title>
        <style>
            /* Global and Reset CSS */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: "segoe ui", verdana, helvetica, arial, sans-serif;
                font-size: 16px;
                transition: all 500ms ease;
            }

            body {
                -webkit-font-smoothing: antialiased;
                -moz-osx-font-smoothing: grayscale;
                text-rendering: optimizeLegibility;
            }

            /* Container Styles */
            .row1 {
                background-color: #aabfa4;
                color: #fff;
                text-align: center;
                padding: 2em 2em 0.5em;
                width: 50%;
                margin: 2em auto;
                border-radius: 5px;
            }

            .row1 h1 {
                font-size: 2.5em;
            }

            .row1 .form-group {
                margin: 0.5em 0;
            }

            .row1 .form-group label {
                display: block;
                color: black;
                text-align: left;
                font-weight: 600;
            }

            .row1 .form-group input, .row1 .form-group button {
                display: block;
                padding: 0.5em 0;
                width: 100%;
                margin-top: 1em;
                background-color: inherit;
                border: none;
                border-bottom: 1px solid #555;
                color: black;
            }

            .row1 .form-group input:focus, .row1 .form-group button:focus {
                background-color: #fff;
                color: black;
                padding: 1em 0.5em;
                animation: pulse 1s infinite ease;
            }

            .row1 .form-group button {
                border: 1px solid #fff;
                border-radius: 5px;
                outline: none;
                font-weight: 800;
                cursor: pointer;
                margin-top: 2em;
                padding: 1em;
            }

            .row1 .form-group button:hover {
                background-color: #fff;
            }

            .information-text {
                color: black;
            }

            .error-message {
                color: red;
                font-weight: bold;
            }

            /* Responsive Styles */
            @media screen and (max-width: 320px) {
                .row1 {
                    padding-left: 1em;
                    padding-right: 1em;
                }

                .row1 h1 {
                    font-size: 1.5em;
                }
            }

            @media screen and (min-width: 900px) {
                .row1 {
                    width: 50%;
                }
            }
        </style>
    </head>
    <body>
           <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.4/dist/sweetalert2.min.js"></script>
        <?php include 'Header.php'; ?>

        <div class="row1">
            <h1>Reset Password</h1>
            <h6 class="information-text">Enter your new password below.</h6>
            <form id="resetPasswordForm" action="../Controller/ResetPasswordController.php" method="POST" onsubmit="return validatePasswordMatch()">
                <div class="form-group">
                    <label for="newPassword">New Password:</label>
                    <input type="password" id="newPassword" name="newPassword" required minlength="8" title="Password must be at least 8 characters long">
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password:</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required minlength="8" title="Password must be at least 8 characters long">
                    <button type="submit">Reset Password</button>
                </div>
                <p id="error-message" class="error-message"></p>
            </form>
        </div>

        <?php include 'Footer.php'; ?>

        <script>
            // Password Matching Validation
            function validatePasswordMatch() {
                const newPassword = document.getElementById("newPassword").value;
                const confirmPassword = document.getElementById("confirmPassword").value;
                const errorMessage = document.getElementById("error-message");

                if (newPassword !== confirmPassword) {
                    errorMessage.textContent = "Passwords do not match. Please try again.";
                    return false;
                }

                return true; // Form submission continues if passwords match
            }
        </script>
    </body>
</html>
