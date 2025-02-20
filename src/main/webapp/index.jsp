<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Mega City Cab</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .login-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .login-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .form-control {
            margin-bottom: 15px;
        }

        .btn-login {
            width: 100%;
        }

        .alert {
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>Login to Mega City Cab</h2>

    <!-- Success message (this will be displayed when login is successful) -->
    <div id="login-success" class="alert alert-success d-none" role="alert">
        Login successful! Redirecting to your dashboard...
    </div>

    <!-- Failure message (this will be displayed when login fails) -->
    <div id="login-alert" class="alert alert-danger d-none" role="alert">
        Invalid username or password. Please try again.
    </div>

    <form action="login" method="post">
        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" class="form-control" id="username" name="username" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
        <button type="submit" class="btn btn-primary btn-login">Login</button>
    </form>

    <!-- Link to registration or other pages -->
    <div class="mt-3 text-center">
        <p>Don't have an account? <a href="register.jsp">Register here</a></p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Check if there's an error or success query parameter in the URL
    const urlParams = new URLSearchParams(window.location.search);
    const error = urlParams.get('error');
    const success = urlParams.get('success');

    // Display the error alert if login failed (error=1)
    if (error === '1') {
        document.getElementById('login-alert').classList.remove('d-none');
    }

    // Display the success alert if login succeeded (success=1)
    if (success === '1') {
        document.getElementById('login-success').classList.remove('d-none');
        // Redirect to dashboard after a short delay
        setTimeout(() => {
            window.location.href = 'dashboard.jsp'; // Redirect to the actual dashboard URL
        }, 2000); // 2 seconds delay before redirect
    }
</script>
</body>
</html>
