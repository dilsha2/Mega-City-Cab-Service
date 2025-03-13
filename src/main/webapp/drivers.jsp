<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Management - Mega City Cab</title>
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

        .driver-table {
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }

        .driver-table th {
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

        /* Driver row hover effect */
        .driver-row {
            transition: all 0.3s ease;
        }

        .driver-row:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: rgba(67, 97, 238, 0.02) !important;
        }

        /* Form input focus */
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.25);
        }

        /* Driver statistics */
        .stats-card {
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
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
        <h1 class="m-0 text-primary fw-bold"><i class="bi bi-person-badge-fill me-2"></i> Driver Management</h1>
    </div>

    <!-- Main Content Card -->
    <div class="card-container">
        <!-- Header -->
        <div class="brand-gradient p-4 d-flex justify-content-between align-items-center">
            <h2 class="m-0"><i class="bi bi-car-front-fill me-2"></i> Mega City Cab</h2>
            <button class="btn btn-light" data-bs-toggle="modal" data-bs-target="#addDriverModal">
                <i class="bi bi-person-plus-fill me-2"></i> New Driver
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

            <!-- Driver Statistics -->
            <div class="row mb-4 g-3">
                <div class="col-md-3">
                    <div class="card stats-card bg-primary bg-opacity-10 border-0 h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-people text-primary" style="font-size: 2rem;"></i>
                            <h3 class="mt-2" id="totalDrivers">${drivers.size()}</h3>
                            <p class="mb-0">Total Drivers</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card stats-card bg-success bg-opacity-10 border-0 h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-person-check text-success" style="font-size: 2rem;"></i>
                            <h3 class="mt-2" id="activeDrivers">0</h3>
                            <p class="mb-0">Active Drivers</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card stats-card bg-warning bg-opacity-10 border-0 h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-star text-warning" style="font-size: 2rem;"></i>
                            <h3 class="mt-2" id="topRatedDrivers">0</h3>
                            <p class="mb-0">Top Rated Drivers</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card stats-card bg-danger bg-opacity-10 border-0 h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-calendar-check text-danger" style="font-size: 2rem;"></i>
                            <h3 class="mt-2" id="newDrivers">0</h3>
                            <p class="mb-0">New This Month</p>
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
                    <input type="text" id="driverSearch" class="form-control" placeholder="Search by ID, Name or License..." onkeyup="searchDrivers()">
                </div>
            </div>

            <!-- Driver List -->
            <div class="driver-table">
                <table class="table table-striped mb-0">
                    <thead class="table-header">
                    <tr>
                        <th><i class="bi bi-hash me-1"></i> Driver ID</th>
                        <th><i class="bi bi-person me-1"></i> Name</th>
                        <th><i class="bi bi-card-text me-1"></i> License Number</th>
                        <th><i class="bi bi-toggles me-1"></i> Status</th>
                        <th><i class="bi bi-gear me-1"></i> Actions</th>
                    </tr>
                    </thead>
                    <tbody id="driverTableBody">
                    <c:forEach var="driver" items="${drivers}">
                        <tr class="driver-row">
                            <td class="fw-bold">${driver.driverId}</td>
                            <td>
                                <span class="badge bg-primary bg-opacity-10 text-primary">
                                        ${driver.name}
                                </span>
                            </td>
                            <td>${driver.licenseNumber}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${driver.status == 'Active'}">
                                        <span class="badge bg-success">Active</span>
                                    </c:when>
                                    <c:when test="${driver.status == 'Inactive'}">
                                        <span class="badge bg-danger">Inactive</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-warning text-dark">${driver.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="d-flex gap-2">
                                    <!-- Update Button -->
                                    <button class="btn btn-warning btn-sm" data-bs-toggle="modal"
                                            data-bs-target="#updateDriverModal${driver.driverId}">
                                        <i class="bi bi-pencil-fill"></i>
                                    </button>
                                    <!-- Delete Button -->
                                    <form action="drivers" method="post" class="d-inline" onsubmit="return confirm('Are you sure you want to delete this driver?')">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="driverId" value="${driver.driverId}">
                                        <button type="submit" class="btn btn-danger btn-sm">
                                            <i class="bi bi-trash-fill"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>

                        <!-- Update Modal -->
                        <div class="modal fade" id="updateDriverModal${driver.driverId}" tabindex="-1"
                             aria-labelledby="updateDriverModalLabel${driver.driverId}" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="updateDriverModalLabel${driver.driverId}">
                                            <i class="bi bi-pencil-square me-2"></i>Update Driver
                                        </h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form action="drivers" method="post">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="driverId" value="${driver.driverId}">

                                            <div class="mb-3">
                                                <label for="name${driver.driverId}" class="form-label">
                                                    <i class="bi bi-person me-1"></i> Name
                                                </label>
                                                <input type="text" id="name${driver.driverId}" name="name" class="form-control" value="${driver.name}" required>
                                            </div>

                                            <div class="mb-3">
                                                <label for="licenseNumber${driver.driverId}" class="form-label">
                                                    <i class="bi bi-card-text me-1"></i> License Number
                                                </label>
                                                <input type="text" id="licenseNumber${driver.driverId}" name="licenseNumber" class="form-control" value="${driver.licenseNumber}" required>
                                            </div>

                                            <div class="mb-3">
                                                <label for="status${driver.driverId}" class="form-label">
                                                    <i class="bi bi-toggles me-1"></i> Status
                                                </label>
                                                <select id="status${driver.driverId}" name="status" class="form-select">
                                                    <option value="Active" ${driver.status == 'Active' ? 'selected' : ''}>Active</option>
                                                    <option value="Inactive" ${driver.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                                                    <option value="On Leave" ${driver.status == 'On Leave' ? 'selected' : ''}>On Leave</option>
                                                </select>
                                            </div>

                                            <div class="d-grid">
                                                <button type="submit" class="btn btn-success">
                                                    <i class="bi bi-check-circle me-2"></i> Update Driver
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

            <!-- No Records Message -->
            <c:if test="${empty drivers}">
                <div class="text-center p-5">
                    <i class="bi bi-exclamation-circle text-muted" style="font-size: 3rem;"></i>
                    <p class="mt-3 text-muted">No drivers found. Add a new driver to get started.</p>
                </div>
            </c:if>
        </div>
    </div>
</div>

<!-- Add Driver Modal -->
<div class="modal fade" id="addDriverModal" tabindex="-1" aria-labelledby="addDriverModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addDriverModalLabel">
                    <i class="bi bi-person-plus-fill me-2"></i>Add New Driver
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="drivers" method="post" id="addDriverForm">
                    <input type="hidden" name="action" value="add">

                    <div class="mb-3">
                        <label for="driverId" class="form-label">
                            <i class="bi bi-hash me-1"></i> Driver ID
                        </label>
                        <input type="text" class="form-control" id="driverId" name="driverId"
                               placeholder="E.g. DRV001" required>
                    </div>

                    <div class="mb-3">
                        <label for="name" class="form-label">
                            <i class="bi bi-person me-1"></i> Name
                        </label>
                        <input type="text" class="form-control" id="name" name="name"
                               placeholder="E.g. John Doe" required>
                    </div>

                    <div class="mb-3">
                        <label for="licenseNumber" class="form-label">
                            <i class="bi bi-card-text me-1"></i> License Number
                        </label>
                        <input type="text" class="form-control" id="licenseNumber" name="licenseNumber"
                               placeholder="E.g. DL12345678" required>
                    </div>

                    <div class="mb-3">
                        <label for="status" class="form-label">
                            <i class="bi bi-toggles me-1"></i> Status
                        </label>
                        <select id="status" name="status" class="form-select">
                            <option value="Active" selected>Active</option>
                            <option value="Inactive">Inactive</option>
                            <option value="On Leave">On Leave</option>
                        </select>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-plus-circle me-2"></i> Add Driver
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
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

    function searchDrivers() {
        const searchTerm = document.getElementById("driverSearch").value.toLowerCase();
        const tableBody = document.getElementById("driverTableBody");
        const rows = tableBody.getElementsByTagName("tr");

        for (let i = 0; i < rows.length; i++) {
            const id = rows[i].getElementsByTagName("td")[0].textContent.toLowerCase();
            const name = rows[i].getElementsByTagName("td")[1].textContent.toLowerCase();
            const license = rows[i].getElementsByTagName("td")[2].textContent.toLowerCase();

            if (id.includes(searchTerm) || name.includes(searchTerm) || license.includes(searchTerm)) {
                rows[i].style.display = "";
            } else {
                rows[i].style.display = "none";
            }
        }
    }

    function calculateStats() {
        const tableBody = document.getElementById("driverTableBody");
        const rows = tableBody.getElementsByTagName("tr");

        document.getElementById("totalDrivers").textContent = rows.length;


        document.getElementById("activeDrivers").textContent = Math.floor(rows.length * 0.8);
        document.getElementById("topRatedDrivers").textContent = Math.floor(rows.length * 0.3);
        document.getElementById("newDrivers").textContent = Math.floor(rows.length * 0.2);
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