<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Mega City Cab</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            background-image: url('https://via.placeholder.com/1500'); /* Add your image URL here */
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            margin: 0;
            height: 100%;
        }

        .dashboard-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background: rgba(255, 255, 255, 0.8); /* Semi-transparent background */
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .dashboard-container h1 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 36px;
            font-weight: bold;
            color: #333;
        }

        .nav-links {
            display: flex;
            justify-content: space-around;
            margin-top: 20px;
        }

        .nav-links a {
            text-decoration: none;
            color: #007bff;
            font-size: 18px;
        }

        .nav-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <h1>Welcome to Mega City Cab</h1>
    <div class="nav-links">
        <a href="customers">Manage Customers</a>
        <a href="bookings">Manage Bookings</a>
        <a href="drivers">Manage Drivers</a>
        <a href="cars">Manage Cars</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
