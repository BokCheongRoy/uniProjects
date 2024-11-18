<?php
/** @author Choo Shi Yi*/

session_start();
?>   
<!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <title>Enter OTP</title>
        <style>
            /* Your existing CSS styles */
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
                -moz-font-feature-settings: "liga" on;
            }

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

            .row1 .form-group input, .row .form-group button {
                display: block;
                padding: 0.5em 0;
                width: 100%;
                margin-top: 1em;
                margin-bottom: 0.5em;
                background-color: inherit;
                border: none;
                border-bottom: 1px solid #555;
                color: black;
            }

            .row1 .form-group input:focus, .row .form-group button:focus {
                background-color: #fff;
                color: black;
                border: none;
                padding: 1em 0.5em;
                animation: pulse 1s infinite ease;
            }

            .row1 .form-group button {
                border: 1px solid #fff;
                border-radius: 5px;
                outline: none;
                -moz-user-select: none;
                user-select: none;
                color: black;
                font-weight: 800;
                cursor: pointer;
                margin-top: 2em;
                padding: 1em;
            }

            .row1 .form-group button:hover, .row .form-group button:focus {
                background-color: #fff;
            }

            .row1 .form-group button.is-loading::after {
                animation: spinner 500ms infinite linear;
                content: "";
                position: absolute;
                margin-left: 2em;
                border: 2px solid #000;
                border-radius: 100%;
                border-right-color: transparent;
                border-left-color: transparent;
                height: 1em;
                width: 4%;
            }

            .row1 .footer h5 {
                margin-top: 1em;
            }

            .row .footer p {
                margin-top: 2em;
            }

            .row1 .footer p .symbols {
                color: black;
            }

            .row1 .footer a {
                color: black;
                text-decoration: none;
            }

            .information-text {
                color: black;
            }

            .error-message {
                color: red;
                font-weight: bold;
            }

            @media screen and (max-width: 320px) {
                .row {
                    padding-left: 1em;
                    padding-right: 1em;
                }
                .row h1 {
                    font-size: 1.5em !important;
                }
            }

            @media screen and (min-width: 900px) {
                .row {
                    width: 50%;
                }
            }
        </style>
    </head>
    <body>
        <?php include 'Header.php'; ?>
        <div class="row1">
            <?php if (isset($_GET['status']) && $_GET['status'] === 'Fail'): ?>
                        <div style="color: red; font-weight: bold;">
                            Fail Verification!
                        </div>
                    <?php endif; ?>
            <h1>Enter OTP</h1>
            <h6 class="information-text">Enter the OTP sent to your phone number.</h6>

            <!-- Display any error or success messages -->
            <?php if (isset($errorMessage)): ?>
                <p class="error-message"><?php echo htmlspecialchars($errorMessage); ?></p>
            <?php endif; ?>
            <?php if (isset($_SESSION['success_message'])): ?>
                <p class="success-message"><?php echo htmlspecialchars($_SESSION['success_message']); ?></p>
            <?php endif; ?>

            <form action="../Controller/ForgotPswController.php" method="POST">


                <div class="form-group">
                    <label for="otp">OTP:</label>
                    <input type="text" id="otp" name="otp" placeholder="Enter 6-digit OTP" pattern="[0-9]{6}" required title="Please enter a 6-digit OTP">
                    <button type="submit">Verify OTP</button>
                </div>
            </form>

            <div class="footer">
                <h5>Back to <a href="ForgotPassword.php">Forgot Password</a></h5>
            </div>
        </div>
    </body>

    <?php include 'Footer.php'; ?>
    </html>
