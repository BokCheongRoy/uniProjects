<?php
/** @author Choo Shi Yi */
?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Forgot Password </title>
        <style>* {
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
                margin: 2em	auto;
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
                color:black;
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
        <?php
        session_start();
        ?>
    </head>
    <body>
        <?php include 'Header.php'; ?>
        <div class="row1">
            <h1>Forgot Password</h1>
            <h6 class="information-text">Enter your registered phone number to get otp .</h6>
            <form action="../Controller/ForgotPswController.php" method="POST">
                <div class="form-group">
                    <label for="phone">Phone Number:</label>
                    <input type="tel" id="phone" name="phone" pattern="^\+60[0-9]{8,12}$" required title="Please enter a valid phone number in the format +60189003136">

                    <button type="submit" onclick="showSpinner()">Reset Password</button>
                </div>
            </form>

            <div class="footer">
                <h5>New here? <a href="Register.php">Register</a></h5>
                <h5>Already have an account? <a href="Login.php">Log In</a></h5>
            </div>
        </div>
    </body>
    <?php include 'Footer.php'; ?>

</html>
