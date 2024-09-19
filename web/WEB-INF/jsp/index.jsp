<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Welcome to EQUIPPRO</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body>
        <!-- Navigation Bar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">EQUIPPRO</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Contact Us</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link btn btn-primary text-white" href="login.php">Get Started</a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Welcome Section -->
        <div class="container mt-5">
            <div class="jumbotron text-center">
                <h1 class="display-4">Welcome to EQUIPPRO</h1>
                <p class="lead">Your comprehensive solution for equipment and asset management.</p>
                <hr class="my-4">
                <p>Track your assets, optimize predictive maintenance, and streamline cost analysis all in one place.</p>
       
                <a class="btn btn-primary btn-lg" href="login.php" role="button">Get Started</a>
            </div>
        </div>

        <!-- Footer -->
        <footer class="bg-light text-center py-4">
            <div class="container">
                <div class="row">
                    <div class="col-md-4">
                        <h5>Important Links</h5>
                        <ul class="list-unstyled">
                            <li><a href="#">Home</a></li>
                            <li><a href="#">About</a></li>
                            <li><a href="#">Contact Us</a></li>
                            <li><a href="login.jsp">Get Started</a></li>
                        </ul>
                    </div>
                </div>
                <p class="text-muted mt-3">EQUIPPRO &copy; 2024 | All rights reserved</p>
            </div>
        </footer>

        <!-- Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
