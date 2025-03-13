<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Management - Mega City Cab</title>
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

        .customer-table {
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }

        .customer-table th {
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

        @keyframes slideDown {
            0% {
                transform: translateY(-20px);
                opacity: 0;
            }
            100% {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .alert-animated {
            animation: slideDown 0.5s ease-in-out;
        }

        .customer-row {
            transition: all 0.3s ease;
        }

        .customer-row:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: rgba(67, 97, 238, 0.02) !important;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.25);
        }

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
        <h1 class="m-0 text-primary fw-bold"><i class="bi bi-people-fill me-2"></i> Customer Management</h1>
    </div>

    <!-- Main Content Card -->
    <div class="card-container">
        <!-- Header -->
        <div class="brand-gradient p-4 d-flex justify-content-between align-items-center">
            <h2 class="m-0"><i class="bi bi-person-fill me-2"></i> Mega City Cab</h2>
            <button class="btn btn-light" data-bs-toggle="modal" data-bs-target="#addCustomerModal">
                <i class="bi bi-person-plus-fill me-2"></i> New Customer
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

            <div class="row mb-4 g-3">
                <div class="col-md-3">
                    <div class="card stats-card bg-primary bg-opacity-10 border-0 h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-people text-primary" style="font-size: 2rem;"></i>
                            <h3 class="mt-2" id="totalCustomers">${customers.size()}</h3>
                            <p class="mb-0">Total Customers</p>
                        </div>
                    </div>
                </div>
                </div>
            </div>

            <div class="mb-4">
                <div class="input-group">
                    <span class="input-group-text bg-primary text-white">
                        <i class="bi bi-search"></i>
                    </span>
                    <input type="text" id="customerSearch" class="form-control"
                           placeholder="Search by Name, NIC or Telephone..." onkeyup="searchCustomers()">
                </div>
            </div>

            <div class="customer-table">
                <table class="table table-striped mb-0">
                    <thead class="table-header">
                    <tr>
                        <th><i class="bi bi-hash me-1"></i> Reg. Number</th>
                        <th><i class="bi bi-person me-1"></i> Name</th>
                        <th><i class="bi bi-geo-alt me-1"></i> Address</th>
                        <th><i class="bi bi-card-text me-1"></i> NIC</th>
                        <th><i class="bi bi-telephone me-1"></i> Telephone</th>
                        <th><i class="bi bi-gear me-1"></i> Actions</th>
                    </tr>
                    </thead>
                    <tbody id="customerTableBody">
                    <c:forEach var="customer" items="${customers}">
                        <tr class="customer-row">
                            <td class="fw-bold">${customer.registrationNumber}</td>
                            <td>
                                <span class="badge bg-primary bg-opacity-10 text-primary">
                                        ${customer.name}
                                </span>
                            </td>
                            <td>${customer.address}</td>
                            <td>${customer.nic}</td>
                            <td>${customer.telephone}</td>
                            <td>
                                <div class="d-flex gap-2">
                                    <!-- Update Button -->
                                    <button class="btn btn-warning btn-sm" data-bs-toggle="modal"
                                            data-bs-target="#updateCustomerModal${customer.registrationNumber}">
                                        <i class="bi bi-pencil-fill"></i>
                                    </button>
                                    <!-- Delete Button -->
                                    <form action="customers" method="post" class="d-inline"
                                          onsubmit="return confirm('Are you sure you want to delete this customer?')">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="registrationNumber"
                                               value="${customer.registrationNumber}">
                                        <button type="submit" class="btn btn-danger btn-sm">
                                            <i class="bi bi-trash-fill"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>

                        <!-- Update Modal -->
                        <div class="modal fade" id="updateCustomerModal${customer.registrationNumber}" tabindex="-1"
                             aria-labelledby="updateCustomerModalLabel${customer.registrationNumber}"
                             aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title"
                                            id="updateCustomerModalLabel${customer.registrationNumber}">
                                            <i class="bi bi-pencil-square me-2"></i>Update Customer
                                        </h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form action="customers" method="post">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="registrationNumber"
                                                   value="${customer.registrationNumber}">

                                            <div class="mb-3">
                                                <label for="name${customer.registrationNumber}" class="form-label">
                                                    <i class="bi bi-person me-1"></i> Name
                                                </label>
                                                <input type="text" id="name${customer.registrationNumber}" name="name"
                                                       class="form-control" value="${customer.name}" required>
                                            </div>

                                            <div class="mb-3">
                                                <label for="address${customer.registrationNumber}" class="form-label">
                                                    <i class="bi bi-geo-alt me-1"></i> Address
                                                </label>
                                                <input type="text" id="address${customer.registrationNumber}"
                                                       name="address" class="form-control" value="${customer.address}"
                                                       required>
                                            </div>

                                            <div class="mb-3">
                                                <label for="nic${customer.registrationNumber}" class="form-label">
                                                    <i class="bi bi-card-text me-1"></i> NIC
                                                </label>
                                                <input type="text" id="nic${customer.registrationNumber}" name="nic"
                                                       class="form-control" value="${customer.nic}" required>
                                            </div>

                                            <div class="mb-3">
                                                <label for="telephone${customer.registrationNumber}" class="form-label">
                                                    <i class="bi bi-telephone me-1"></i> Telephone
                                                </label>
                                                <input type="text" id="telephone${customer.registrationNumber}"
                                                       name="telephone" class="form-control"
                                                       value="${customer.telephone}" required>
                                            </div>

                                            <div class="d-grid">
                                                <button type="submit" class="btn btn-success">
                                                    <i class="bi bi-check-circle me-2"></i> Update Customer
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

            <c:if test="${empty customers}">
                <div class="text-center p-5">
                    <i class="bi bi-exclamation-circle text-muted" style="font-size: 3rem;"></i>
                    <p class="mt-3 text-muted">No customers found. Add a new customer to get started.</p>
                </div>
            </c:if>
        </div>
    </div>
</div>

<!-- Add Customer Modal -->
<div class="modal fade" id="addCustomerModal" tabindex="-1" aria-labelledby="addCustomerModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addCustomerModalLabel">
                    <i class="bi bi-person-plus-fill me-2"></i>Add New Customer
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="customers" method="post" id="addCustomerForm">
                    <input type="hidden" name="action" value="add">

                    <div class="mb-3">
                        <label for="registrationNumber" class="form-label">
                            <i class="bi bi-hash me-1"></i> Registration Number
                        </label>
                        <input type="text" class="form-control" id="registrationNumber" name="registrationNumber"
                               placeholder="E.g. CUST001" required>
                    </div>

                    <div class="mb-3">
                        <label for="name" class="form-label">
                            <i class="bi bi-person me-1"></i> Name
                        </label>
                        <input type="text" class="form-control" id="name" name="name"
                               placeholder="E.g. John Doe" required>
                    </div>

                    <div class="mb-3">
                        <label for="address" class="form-label">
                            <i class="bi bi-geo-alt me-1"></i> Address
                        </label>
                        <input type="text" class="form-control" id="address" name="address"
                               placeholder="E.g. 123 Main St, Colombo" required>
                    </div>

                    <div class="mb-3">
                        <label for="nic" class="form-label">
                            <i class="bi bi-card-text me-1"></i> NIC
                        </label>
                        <input type="text" class="form-control" id="nic" name="nic"
                               placeholder="E.g. 123456789V" required>
                    </div>

                    <div class="mb-3">
                        <label for="telephone" class="form-label">
                            <i class="bi bi-telephone me-1"></i> Telephone
                        </label>
                        <input type="text" class="form-control" id="telephone" name="telephone"
                               placeholder="E.g. 0771234567" required>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-plus-circle me-2"></i> Add Customer
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
    function searchCustomers() {
        const searchTerm = document.getElementById("customerSearch").value.toLowerCase();
        const tableBody = document.getElementById("customerTableBody");
        const rows = tableBody.getElementsByTagName("tr");

        for (let i = 0; i < rows.length; i++) {
            const name = rows[i].getElementsByTagName("td")[1].textContent.toLowerCase();
            const nic = rows[i].getElementsByTagName("td")[3].textContent.toLowerCase();
            const telephone = rows[i].getElementsByTagName("td")[4].textContent.toLowerCase();

            if (name.includes(searchTerm) || nic.includes(searchTerm) || telephone.includes(searchTerm)) {
                rows[i].style.display = "";
            } else {
                rows[i].style.display = "none";
            }
        }
    }

    function calculateStats() {
        const tableBody = document.getElementById("customerTableBody");
        const rows = tableBody.getElementsByTagName("tr");

        document.getElementById("totalCustomers").textContent = rows.length;
    }

    window.onload = function () {
        checkUrlParams();
        calculateStats();
    };
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>