<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Car Management - Mega City Cab</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #f72585;
            --success-color: #4cc9f0;
            --light-bg: #f0f2f5;
            --dark-text: #212529;
        }

        body {
            background-color: #f0f2f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .brand-gradient {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 15px;
            border-radius: 8px 8px 0 0;
            margin-bottom: 0;
        }

        .card-container {
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            border: none;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-primary:hover {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
        }

        .btn-success {
            background-color: var(--success-color);
            border-color: var(--success-color);
            color: var(--dark-text);
            font-weight: 600;
        }

        .btn-danger {
            background-color: var(--accent-color);
            border-color: var(--accent-color);
        }

        .btn-warning {
            background-color: #ffbe0b;
            border-color: #ffbe0b;
            color: var(--dark-text);
        }

        .table-header {
            background-color: var(--primary-color);
            color: white;
        }

        .home-btn {
            transition: all 0.3s ease;
        }

        .home-btn:hover {
            transform: translateY(-2px);
        }

        .car-table {
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }

        .car-table th {
            font-weight: 600;
        }

        .table-striped > tbody > tr:nth-of-type(odd) > * {
            background-color: rgba(67, 97, 238, 0.05);
        }

        .action-buttons .btn {
            margin: 0 3px;
            border-radius: 50px;
            padding: 5px 15px;
        }

        .modal-content {
            border-radius: 12px;
            overflow: hidden;
        }

        .modal-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border-bottom: none;
        }

        /* Animation for alerts */
        @keyframes slideDown {
            0% { transform: translateY(-20px); opacity: 0; }
            100% { transform: translateY(0); opacity: 1; }
        }

        .alert-animated {
            animation: slideDown 0.5s ease-in-out;
        }

        /* Car status badges */
        .status-available {
            background-color: rgba(76, 201, 240, 0.2);
            color: #4cc9f0;
            border-radius: 50px;
            padding: 5px 15px;
            font-weight: 600;
        }

        .status-unavailable {
            background-color: rgba(247, 37, 133, 0.2);
            color: #f72585;
            border-radius: 50px;
            padding: 5px 15px;
            font-weight: 600;
        }

        /* Car card hover effect */
        .car-row {
            transition: all 0.3s ease;
        }

        .car-row:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: rgba(67, 97, 238, 0.02) !important;
        }

        /* Form input focus */
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.25);
        }
    </style>
</head>
<body>
<div class="container mt-5 mb-5">
    <!-- Top Navigation -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <a href="dashboard.jsp" class="btn btn-outline-primary home-btn">
            <i class="bi bi-house-door-fill me-2"></i> Dashboard
        </a>
        <h1 class="m-0 text-primary fw-bold"><i class="bi bi-car-front me-2"></i> Car Management</h1>
    </div>

    <!-- Main Content Card -->
    <div class="card-container">
        <!-- Header -->
        <div class="brand-gradient p-4 d-flex justify-content-between align-items-center">
            <h2 class="m-0"><i class="bi bi-car-front-fill me-2"></i> Mega City Cab</h2>
            <button class="btn btn-light" data-bs-toggle="modal" data-bs-target="#addCarModal">
                <i class="bi bi-plus-circle-fill me-2"></i> New Car
            </button>
        </div>

        <div class="p-4 bg-white">
            <!-- Success and Error Alerts -->
            <div id="successAlert" class="alert alert-success d-none alert-animated" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> Operation completed successfully!
            </div>
            <div id="errorAlert" class="alert alert-danger d-none alert-animated" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i> Error occurred while processing your request.
            </div>

            <!-- Car Statistics -->
            <div class="row mb-4 g-3">
                <div class="col-md-3">
                    <div class="card bg-primary bg-opacity-10 border-0 h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-car-front text-primary" style="font-size: 2rem;"></i>
                            <h3 class="mt-2">${cars.size()}</h3>
                            <p class="mb-0">Total Vehicles</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card bg-success bg-opacity-10 border-0 h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-check-circle text-success" style="font-size: 2rem;"></i>
                            <h3 class="mt-2" id="availableCars">0</h3>
                            <p class="mb-0">Available Cars</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card bg-danger bg-opacity-10 border-0 h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-x-circle text-danger" style="font-size: 2rem;"></i>
                            <h3 class="mt-2" id="unavailableCars">0</h3>
                            <p class="mb-0">Unavailable Cars</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card bg-warning bg-opacity-10 border-0 h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-currency-dollar text-warning" style="font-size: 2rem;"></i>
                            <h3 class="mt-2" id="avgPrice">0</h3>
                            <p class="mb-0">Avg. Rate/km</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Search Bar -->
            <div class="mb-4">
                <div class="input-group">
                    <span class="input-group-text bg-primary text-white">
                        <i class="bi bi-search"></i>
                    </span>
                    <input type="text" id="carSearch" class="form-control" placeholder="Search by Model or License Plate..." onkeyup="searchCars()">
                </div>
            </div>

            <!-- Car List -->
            <div class="car-table">
                <table class="table table-striped mb-0">
                    <thead class="table-header">
                    <tr>
                        <th><i class="bi bi-tag me-1"></i> Car ID</th>
                        <th><i class="bi bi-truck me-1"></i> Model</th>
                        <th><i class="bi bi-card-text me-1"></i> License Plate</th>
                        <th><i class="bi bi-currency-dollar me-1"></i> Rate/km</th>
                        <th><i class="bi bi-circle-fill me-1"></i> Status</th>
                        <th><i class="bi bi-gear me-1"></i> Actions</th>
                    </tr>
                    </thead>
                    <tbody id="carTableBody">
                    <c:forEach var="car" items="${cars}">
                        <tr class="car-row">
                            <td class="fw-bold">${car.carId}</td>
                            <td>
                                <span class="badge bg-primary bg-opacity-10 text-primary">
                                        ${car.model}
                                </span>
                            </td>
                            <td>${car.licensePlate}</td>
                            <td>LKR ${car.price}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${car.status == 'AVAILABLE'}">
                                        <span class="status-available">
                                            <i class="bi bi-check-circle-fill me-1"></i> Available
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-unavailable">
                                            <i class="bi bi-x-circle-fill me-1"></i> Unavailable
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="d-flex gap-2">
                                    <!-- Update Button -->
                                    <button class="btn btn-warning btn-sm" data-bs-toggle="modal"
                                            data-bs-target="#updateCarModal${car.carId}">
                                        <i class="bi bi-pencil-fill"></i>
                                    </button>
                                    <!-- Delete Button -->
                                    <form action="cars" method="post" class="d-inline" onsubmit="return confirm('Are you sure you want to delete this car?')">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="carId" value="${car.carId}">
                                        <button type="submit" class="btn btn-danger btn-sm">
                                            <i class="bi bi-trash-fill"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>

                        <!-- Update Modal -->
                        <div class="modal fade" id="updateCarModal${car.carId}" tabindex="-1"
                             aria-labelledby="updateCarModalLabel${car.carId}" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="updateCarModalLabel${car.carId}">
                                            <i class="bi bi-pencil-square me-2"></i>Update Car
                                        </h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form action="cars" method="post">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="carId" value="${car.carId}">

                                            <div class="mb-3">
                                                <label for="model${car.carId}" class="form-label">
                                                    <i class="bi bi-truck me-1"></i> Model
                                                </label>
                                                <input type="text" id="model${car.carId}" name="model" class="form-control" value="${car.model}" required>
                                            </div>

                                            <div class="mb-3">
                                                <label for="licensePlate${car.carId}" class="form-label">
                                                    <i class="bi bi-card-text me-1"></i> License Plate
                                                </label>
                                                <input type="text" id="licensePlate${car.carId}" name="licensePlate" class="form-control" value="${car.licensePlate}" required>
                                            </div>

                                            <div class="mb-3">
                                                <label for="price${car.carId}" class="form-label">
                                                    <i class="bi bi-currency-dollar me-1"></i> Rate per km
                                                </label>
                                                <input type="number" step="0.01" id="price${car.carId}" name="price" class="form-control" value="${car.price}" required>
                                            </div>

                                            <div class="mb-3">
                                                <label for="status${car.carId}" class="form-label">
                                                    <i class="bi bi-circle-fill me-1"></i> Status
                                                </label>
                                                <select id="status${car.carId}" name="status" class="form-select">
                                                    <option value="Available" ${car.status == 'Available' ? 'selected' : ''}>Available</option>
                                                    <option value="Unavailable" ${car.status == 'Unavailable' ? 'selected' : ''}>Unavailable</option>
                                                </select>
                                            </div>

                                            <div class="d-grid">
                                                <button type="submit" class="btn btn-success">
                                                    <i class="bi bi-check-circle me-2"></i> Update Car
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Add Car Modal -->
<div class="modal fade" id="addCarModal" tabindex="-1" aria-labelledby="addCarModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addCarModalLabel">
                    <i class="bi bi-plus-circle me-2"></i>Add New Car
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="cars" method="post" id="addCarForm">
                    <input type="hidden" name="action" value="add">

                    <div class="mb-3">
                        <label for="carId" class="form-label">
                            <i class="bi bi-tag me-1"></i> Car ID
                        </label>
                        <input type="text" class="form-control" id="carId" name="carId"
                               placeholder="E.g. CAR001" required>
                    </div>

                    <div class="mb-3">
                        <label for="model" class="form-label">
                            <i class="bi bi-truck me-1"></i> Model
                        </label>
                        <input type="text" class="form-control" id="model" name="model"
                               placeholder="E.g. Toyota Camry" required>
                    </div>

                    <div class="mb-3">
                        <label for="licensePlate" class="form-label">
                            <i class="bi bi-card-text me-1"></i> License Plate
                        </label>
                        <input type="text" class="form-control" id="licensePlate" name="licensePlate"
                               placeholder="E.g. ABC-1234" required>
                    </div>

                    <div class="mb-3">
                        <label for="price" class="form-label">
                            <i class="bi bi-currency-dollar me-1"></i> Rate per km
                        </label>
                        <input type="number" step="0.01" class="form-control" id="price" name="price"
                               placeholder="E.g. 80.00" required>
                    </div>

                    <div class="mb-3">
                        <label for="newCarStatus" class="form-label">
                            <i class="bi bi-circle-fill me-1"></i> Status
                        </label>
                        <select id="newCarStatus" name="status" class="form-select">
                            <option value="Available" selected>Available</option>
                            <option value="Unavailable">Unavailable</option>
                        </select>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-plus-circle me-2"></i> Add Car
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    // Check URL parameters for alerts
    function checkUrlParams() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has("success")) {
            document.getElementById('successAlert').classList.remove('d-none');
            setTimeout(() => {
                document.getElementById('successAlert').classList.add('d-none');
            }, 5000);
        }
        if (urlParams.has("error")) {
            document.getElementById('errorAlert').classList.remove('d-none');
            setTimeout(() => {
                document.getElementById('errorAlert').classList.add('d-none');
            }, 5000);
        }
    }

    // Search functionality
    function searchCars() {
        const searchTerm = document.getElementById("carSearch").value.toLowerCase();
        const tableBody = document.getElementById("carTableBody");
        const rows = tableBody.getElementsByTagName("tr");

        for (let i = 0; i < rows.length; i++) {
            const model = rows[i].getElementsByTagName("td")[1].textContent.toLowerCase();
            const license = rows[i].getElementsByTagName("td")[2].textContent.toLowerCase();

            if (model.includes(searchTerm) || license.includes(searchTerm)) {
                rows[i].style.display = "";
            } else {
                rows[i].style.display = "none";
            }
        }
    }

    // Calculate car statistics
    function calculateStats() {
        const tableBody = document.getElementById("carTableBody");
        const rows = tableBody.getElementsByTagName("tr");
        let available = 0;
        let unavailable = 0;
        let totalPrice = 0;

        for (let i = 0; i < rows.length; i++) {
            const status = rows[i].getElementsByTagName("td")[4].textContent.trim();
            const price = parseFloat(rows[i].getElementsByTagName("td")[3].textContent.replace('LKR ', ''));

            if (status.includes('Available')) {
                available++;
            } else {
                unavailable++;
            }

            totalPrice += price;
        }

        document.getElementById("availableCars").textContent = available;
        document.getElementById("unavailableCars").textContent = unavailable;

        const avgPrice = rows.length > 0 ? Math.round(totalPrice / rows.length) : 0;
        document.getElementById("avgPrice").textContent = avgPrice;
    }

    // Initialize page
    window.onload = function() {
        checkUrlParams();
        calculateStats();
    };
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>