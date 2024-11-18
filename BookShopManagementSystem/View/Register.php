<?php 
/** @author Choo Shi Yi */
?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BQY Register</title>
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
                <form class="col-md-9 m-auto" method="post" action="../Controller/RegisterController.php">
                    <h3>Register</h3>

                    <!-- Error Message Display -->
                    <?php if (isset($_GET['status']) && $_GET['status'] === 'success'): ?>
                        <div style="color: green; font-weight: bold;">
                            <?= htmlspecialchars($_GET['message'] ?? 'Operation successful!') ?>
                            <a href="../View/Login.php">Register Successful !Click here to login</a>
                        </div>
                    <?php elseif (isset($_GET['status']) && $_GET['status'] === 'error'): ?>
                        <div class="alert alert-danger" role="alert">
                            <?= htmlspecialchars($_GET['message'] ?? 'An error occurred.') ?>
                        </div>
                    <?php endif; ?>

                    <div class="mb-3">
                        <label for="inputname">Name</label>
                        <input type="text" class="form-control mt-1" id="name" name="name" 
                               value="<?php echo isset($name) ? htmlspecialchars($name) : ''; ?>" 
                               placeholder="Name" required>
                    </div>

                    <div class="mb-3">
                        <label for="inputusername">Username</label>
                        <input type="text" class="form-control mt-1" id="username" name="username" 
                               value="<?php echo isset($username) ? htmlspecialchars($username) : ''; ?>" 
                               placeholder="Username" required>
                    </div>

                    
                    <div class="mb-3">
                        <label for="inputemail">Email</label>
                        <input type="email" class="form-control mt-1" id="email" name="email" 
                               value="<?php echo isset($email) ? htmlspecialchars($email) : ''; ?>" 
                               placeholder="example@gmail.com"  pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2, 4}$" required>
                    </div>

                    <div class="mb-3">
                        <label for="inputphonenumber">Phone Number</label>
                        <input type="text" class="form-control mt-1" id="pNumber" name="pNumber" 
                               value="<?php echo isset($phoneNum) ? htmlspecialchars($phoneNum) : ''; ?>" 
                               required  pattern="01[0-9]{1}-[0-9]{7,8}" title="Please enter a valid phone number (e.g., 01X-XXXXXXX)" 
                               placeholder="01X-XXXXXXX" required>
                    </div>
                    <div class="mb-3">
                        <label for="inputpassword">Password</label>
                        <input type="password" class="form-control mt-1" id="password" name="password" placeholder="Password" required>
                        <input type="checkbox" onclick="togglePassword('password')"><span class="show-password">Show Password</span>
                    </div>

                    <div class="mb-3">
                        <label for="inputconfirmpassword">Confirm Password</label>
                        <input type="password" class="form-control mt-1" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required>
                        <input type="checkbox" onclick="togglePassword('confirmPassword')"><span class="show-password">Show Password</span>
                    </div>


                    <div class="row">
                        <div class="col text-end mt-2">
                            Already have an account? <a href="Login.php">Login Now!</a>
                            <button type="submit" class="btn btn-success btn-lg px-3">Register</button>
                        </div>
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