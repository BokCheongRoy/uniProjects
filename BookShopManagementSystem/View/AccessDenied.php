<?php 
/** @author Bok Cheong Roy */
?>
<!DOCTYPE html>

<html>
    <head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <style>
            img {
                display: block;
                margin: 0 auto;
            }
        </style>
    </head>
    <body>
        <?php include 'Header.php'; ?>

        <div class="container py-5">
            <div class="row">
                <?php if ($adminId || $empId): ?>
                    <?php include 'ControlSidebar.php'; ?>
                <?php endif; ?>
                <!-- Display Most Popular Book -->
                <!--                <div id="template-mo-zay-hero-carousel" class="carousel slide" data-bs-ride="carousel">
                                    <div class="carousel-inner">
                                        <div class="carousel-item active">
                                            <div class="container">
                                                <div class="row p-5">
                                                    <div class="col-lg-6 mb-0 d-flex align-items-center">
                                                        <div class="text-align-left align-self-center">-->

                <div class="col-lg-9">
                    <h1 class="h1 text-dark"><b>Access Denied</b></h1>
                    <h2 class="h2 text-dark"><p>You do not have permission to access this page.</p></h2>
                </div>

                <!--                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>-->
            </div>
        </div>
        <!--Start of Tawk.to LiveChat Script-->
        <script type="text/javascript">
            var Tawk_API = Tawk_API || {}, Tawk_LoadStart = new Date();
            (function () {
                var s1 = document.createElement("script"), s0 = document.getElementsByTagName("script")[0];
                s1.async = true;
                s1.src = 'https://embed.tawk.to/66e03ef3ea492f34bc1093c5/1i7dvbqc1';
                s1.charset = 'UTF-8';
                s1.setAttribute('crossorigin', '*');
                s0.parentNode.insertBefore(s1, s0);
            })();
        </script>
        <!--End of Tawk.to Script-->
        <?php include 'Footer.php'; ?>
    </body>
</html>
