<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Mega City Cab</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        :root {
            --primary-color: #4e54c8;
            --secondary-color: #8f94fb;
            --accent-color: #ff6b6b;
            --text-dark: #2d3436;
            --text-light: #636e72;
            --white: #ffffff;
            --glass-bg: rgba(255, 255, 255, 0.85);
            --glass-border: rgba(255, 255, 255, 0.18);
            --card-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            margin: 0;
            height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('https://via.placeholder.com/1500');
            background-size: cover;
            background-position: center;
            filter: blur(3px) brightness(0.7);
            z-index: -1;
        }

        .dashboard-container {
            width: 100%;
            max-width: 900px;
            margin: 20px;
            padding: 40px;
            background: var(--glass-bg);
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .dashboard-container::before {
            content: "";
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 80%);
            transform: rotate(45deg);
            pointer-events: none;
        }

        .dashboard-container h1 {
            text-align: center;
            margin-bottom: 40px;
            font-size: 42px;
            font-weight: 700;
            color: var(--text-dark);
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
            position: relative;
        }

        .dashboard-container h1::after {
            content: "";
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            border-radius: 4px;
        }

        .dashboard-logo {
            text-align: center;
            margin-bottom: 20px;
        }

        .dashboard-logo i {
            font-size: 48px;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
        }

        .nav-card-container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
            margin-top: 40px;
        }

        .nav-card {
            background: var(--white);
            border-radius: 15px;
            padding: 30px 20px;
            text-align: center;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(0, 0, 0, 0.05);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .nav-card:hover {
            transform: translateY(-7px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.12);
        }

        .nav-card::before {
            content: "";
            position: absolute;
            bottom: -40px;
            right: -40px;
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: rgba(78, 84, 200, 0.1);
            transition: all 0.5s ease;
        }

        .nav-card:hover::before {
            transform: scale(3);
        }

        .nav-card i {
            font-size: 36px;
            margin-bottom: 15px;
            color: var(--primary-color);
            transition: all 0.3s ease;
        }

        .nav-card:hover i {
            transform: scale(1.1);
        }

        .nav-card h3 {
            margin: 0;
            font-size: 18px;
            font-weight: 600;
            color: var(--text-dark);
            position: relative;
            z-index: 1;
        }

        /* Logout Button */
        .logout-btn {
            position: absolute;
            top: 20px;
            right: 20px;
            display: flex;
            align-items: center;
            padding: 10px 15px;
            background-color: rgba(220, 53, 69, 0.1);
            border-radius: 50px;
            font-size: 16px;
            color: var(--accent-color);
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .logout-btn i {
            margin-right: 8px;
        }

        .logout-btn:hover {
            background-color: var(--accent-color);
            color: var(--white);
            box-shadow: 0 5px 15px rgba(220, 53, 69, 0.3);
        }

        .user-greeting {
            text-align: center;
            color: var(--text-light);
            margin-bottom: 30px;
            font-size: 16px;
        }

        .current-time {
            position: absolute;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 14px;
            color: var(--text-light);
        }

        @media (max-width: 768px) {
            .dashboard-container {
                padding: 30px 20px;
            }

            .nav-card-container {
                grid-template-columns: 1fr;
            }

            .dashboard-container h1 {
                font-size: 32px;
            }
        }
    </style>
</head>
<body>

<div class="dashboard-container">
    <!-- Logout Button -->
    <a href="index.jsp" class="logout-btn" title="Logout">
        <i class="fas fa-sign-out-alt"></i> Logout
    </a>

    <div class="dashboard-logo">
        <i class="fas fa-taxi"></i>
    </div>

    <h1>Mega City Cab</h1>

    <div class="user-greeting">
        Welcome back, Admin! Your taxi management system is ready.
    </div>

    <div class="nav-card-container">
        <a href="customers" class="nav-card" style="text-decoration: none;">
            <i class="fas fa-users"></i>
            <h3>Manage Customers</h3>
        </a>
        <a href="bookings" class="nav-card" style="text-decoration: none;">
            <i class="far fa-calendar-check"></i>
            <h3>Manage Bookings</h3>
        </a>
        <a href="drivers" class="nav-card" style="text-decoration: none;">
            <i class="fas fa-id-card"></i>
            <h3>Manage Drivers</h3>
        </a>
        <a href="cars" class="nav-card" style="text-decoration: none;">
            <i class="fas fa-car"></i>
            <h3>Manage Cars</h3>
        </a>
    </div>

    <div class="current-time" id="current-time"></div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function updateTime() {
        const timeElement = document.getElementById('current-time');
        const now = new Date();
        const options = {
            weekday: 'long',
            year: 'numeric',
            month: 'long',
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        };
        timeElement.textContent = now.toLocaleDateString('en-US', options);
    }

    updateTime();
    setInterval(updateTime, 60000);
</script>

</body>
</html>