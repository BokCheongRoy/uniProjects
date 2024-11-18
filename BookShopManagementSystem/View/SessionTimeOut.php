<?php 
/** @author Lee Weng Yi */
?>
<!DOCTYPE html>
<html>
    <head>
         <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Session Expired</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f5f5f5;
            font-family: Arial, sans-serif;
        }
        .container {
            margin-top: 100px;
            text-align: center;
        }
        .timer-icon {
            width: 150px;
            margin-bottom: 20px;
        }
        .error-text {
            color: #e74c3c;
            font-size: 24px;
            margin-bottom: 10px;
        }
        .message-text {
            font-size: 18px;
            margin-bottom: 20px;
        }
        .message-text strong {
            color: #e74c3c;
        }
        .btn-login {
            background-color: #3498db;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            margin-top: 20px;
        }
        .btn-login:hover {
            background-color: #2980b9;
        }
        .footer {
            margin-top: 100px;
            font-size: 12px;
        }
        .footer a {
            text-decoration: none;
            color: #3498db;
        }
        .social-icons {
            margin-top: 20px;
        }
        .social-icons i {
            font-size: 20px;
            color: #666;
            margin: 0 10px;
        }
    </style>
    </head>
    <body>
       <div class="container">

        <div class="error-text">
            <i class="fas fa-exclamation-circle"></i> Your session time has expired!
        </div>

        <div class="message-text">
            Please re-login to continue.<br>
            If you have unsaved changes, <strong>unfortunately, they will not be saved.</strong>
        </div>

        <a href="Login.php" class="btn-login">
            <i class="fas fa-arrow-left"></i>Go to Login.
        </a>

        <div class="footer">
            <a href="#">Disclaimer</a> | <a href="#">Privacy Policy</a><br>
            © 2024 BQY Book Shop. All Rights Reserved            
        </div>
    </div>

    </body>
</html>
