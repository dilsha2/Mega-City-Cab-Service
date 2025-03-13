<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Mega City Cab</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-container {
            max-width: 450px;
            width: 100%;
            padding: 30px 40px;
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease;
        }

        .login-container:hover {
            transform: translateY(-5px);
        }

        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-header h2 {
            color: #4a4a4a;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .login-header p {
            color: #777;
            font-size: 14px;
        }

        .form-label {
            font-weight: 500;
            color: #555;
        }

        .form-control {
            height: 50px;
            padding: 10px 15px;
            border: 2px solid #e1e1e1;
            border-radius: 8px;
            transition: all 0.3s;
        }

        .form-control:focus {
            border-color: #764ba2;
            box-shadow: 0 0 0 0.2rem rgba(118, 75, 162, 0.25);
        }

        .input-group {
            margin-bottom: 20px;
        }

        .input-group-text {
            background-color: #f8f9fa;
            border: 2px solid #e1e1e1;
            border-right: none;
            color: #777;
        }

        .btn-login {
            height: 50px;
            background: linear-gradient(to right, #667eea, #764ba2);
            border: none;
            border-radius: 8px;
            font-weight: 500;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            margin-top: 10px;
            transition: all 0.3s;
        }

        .btn-login:hover {
            background: linear-gradient(to right, #764ba2, #667eea);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(118, 75, 162, 0.4);
        }

        .alert {
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 25px;
        }

        .register-link {
            text-align: center;
            margin-top: 25px;
            color: #777;
        }

        .register-link a {
            color: #764ba2;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }

        .register-link a:hover {
            color: #667eea;
            text-decoration: underline;
        }

        .logo {
            text-align: center;
            margin-bottom: 20px;
        }

        .logo i {
            font-size: 48px;
            background: linear-gradient(to right, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="logo">
        <i class="fas fa-taxi"></i>
    </div>

    <div class="login-header">
        <h2>Welcome Back</h2>
        <p>Enter your credentials to access your Mega City Cab account</p>
    </div>

    <!-- Success message -->
    <div id="login-success" class="alert alert-success d-none" role="alert">
        <i class="fas fa-check-circle me-2"></i> Login successful! Redirecting to your dashboard...
    </div>

    <!-- Failure message -->
    <div id="login-alert" class="alert alert-danger d-none" role="alert">
        <i class="fas fa-exclamation-circle me-2"></i> Invalid username or password. Please try again.
    </div>

    <form action="login" method="post">
        <div class="input-group mb-3">
            <span class="input-group-text">
                <i class="fas fa-user"></i>
            </span>
            <input type="text" class="form-control" id="username" name="username" placeholder="Enter your username" required>
        </div>

        <div class="input-group mb-4">
            <span class="input-group-text">
                <i class="fas fa-lock"></i>
            </span>
            <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
        </div>

        <div class="d-flex justify-content-between align-items-center mb-4">
            <div class="form-check">
                <input class="form-check-input" type="checkbox" id="remember-me">
                <label class="form-check-label" for="remember-me">Remember me</label>
            </div>
            <a href="#" class="text-decoration-none" style="color: #764ba2; font-size: 14px;">Forgot password?</a>
        </div>

        <button type="submit" class="btn btn-primary btn-login w-100">
            Login <i class="fas fa-sign-in-alt ms-2"></i>
        </button>
    </form>

    <div class="register-link">
        <p>Don't have an account? <a href="register.jsp">Register here</a></p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Check URL parameters for error/success messages
    const urlParams = new URLSearchParams(window.location.search);
    const error = urlParams.get('error');
    const success = urlParams.get('success');

    // Display error alert if login failed
    if (error === '1') {
        document.getElementById('login-alert').classList.remove('d-none');
    }

    // Display success alert and redirect if login succeeded
    if (success === '1') {
        document.getElementById('login-success').classList.remove('d-none');
        // Redirect to dashboard after delay
        setTimeout(() => {
            window.location.href = 'dashboard.jsp';
        }, 2000);
    }
</script>
</body>
</html>