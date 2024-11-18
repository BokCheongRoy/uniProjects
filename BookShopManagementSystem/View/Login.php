<?php
/** @author Choo Shi Yi */
?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        .show-password {
            font-size: 0.8em; /* Adjust the size as needed */
        }
        .form-control {
            border: 1px solid #77C717 !important; /* Add border color to all input fields */
        }
    </style>
</head>
<body>
    <?php include 'Header.php'; ?>

    <div class="container py-5">
        <div class="row py-5">
            <form class="col-md-9 m-auto" method="post" action="../Controller/LoginController.php">
                <h3>Login</h3>

                <?php if (isset($_SESSION['error'])): ?>
                    <div class="alert alert-danger"><?php echo htmlspecialchars($_SESSION['error']); ?></div>
                    <?php unset($_SESSION['error']); // Clear the error message after displaying ?>
                <?php endif; ?>
                <?php if (isset($_SESSION['success'])): ?>
                    <div class="alert alert-success"><?php echo htmlspecialchars($_SESSION['success']); ?></div>
                    <?php unset($_SESSION['success']); // Clear the success message after displaying ?>
                <?php endif; ?>

                <div class="mb-3">
                    <label for="inputusername">Username</label>
                    <input type="text" class="form-control mt-1" id="username" name="username" placeholder="Username" required>
                </div>

                <div class="mb-3">
                    <label for="inputpassword">Password</label>
                    <input type="password" class="form-control mt-1" id="password" name="password" placeholder="Password" required>
                    <input type="checkbox" onclick="togglePassword('password')"><span class="show-password">Show Password</span>
                </div>

                <div class="row">
                    <div class="col text-end mt-2">
                      <a href="ForgotPassword.php">Forgot Password</a>
                        <br>   Don't have an account? <a href="Register.php">Register Now!</a>
                       
                    </div>
                    <button type="submit" class="btn btn-success btn-lg px-3">Login</button>
                </div>
            </form>
        </div>
    </div>

    <?php include 'Footer.php'; ?>
    <script>
        function togglePassword(inputId) {
            var x = document.getElementById(inputId);
            if (x.type === "password") {
                x.type = "text";
            } else {
                x.type = "password";
            }
        }
    </script>
</body>
</html>
