<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Management - Mega City Cab</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #f72585;
            --success-color: #4cc9f0;
            --light-bg: #f8f9fa;
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

        .table-header {
            background-color: var(--primary-color);
            color: white;
        }

        .search-container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            margin-bottom: 20px;
        }

        .home-btn {
            transition: all 0.3s ease;
        }

        .home-btn:hover {
            transform: translateY(-2px);
        }

        .booking-table {
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }

        .booking-table th {
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

        .input-group-text {
            background-color: var(--primary-color);
            color: white;
            border: 1px solid var(--primary-color);
        }

        /* Toast styling */
        .toast {
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            border: none;
            border-radius: 8px;
            overflow: hidden;
        }

        .toast-header {
            border-bottom: none;
            padding: 0.75rem 1rem;
        }

        .toast-body {
            padding: 1rem;
        }

        @keyframes highlight {
            0% { background-color: rgba(76, 201, 240, 0.3); }
            100% { background-color: transparent; }
        }

        .new-booking {
            animation: highlight 2s ease-in-out;
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
        <h1 class="m-0 text-primary fw-bold"><i class="bi bi-calendar-check me-2"></i> Booking Management</h1>
    </div>

    <!-- Main Content Card -->
    <div class="card-container">
        <!-- Header -->
        <div class="brand-gradient p-4 d-flex justify-content-between align-items-center">
            <h2 class="m-0"><i class="bi bi-car-front-fill me-2"></i> Mega City Cab</h2>
            <button class="btn btn-light" data-bs-toggle="modal" data-bs-target="#addBookingModal">
                <i class="bi bi-plus-circle-fill me-2"></i> New Booking
            </button>
        </div>

        <div class="p-4 bg-white">
            <!-- Success Alert -->
            <c:if test="${not empty param.success}">
                <div class="alert alert-success alert-dismissible fade show text-center" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i> Booking added successfully!
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>

                <!-- Additional Toast Notification -->
                <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
                    <div id="bookingSuccessToast" class="toast show" role="alert" aria-live="assertive" aria-atomic="true">
                        <div class="toast-header bg-success text-white">
                            <i class="bi bi-check-circle-fill me-2"></i>
                            <strong class="me-auto">Booking Confirmation</strong>
                            <small>Just now</small>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
                        </div>
                        <div class="toast-body">
                            <p class="mb-1">Booking #${param.bookingNumber} has been created successfully!</p>
                            <p class="mb-0 small text-muted">The booking details have been saved to the system.</p>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Search Section -->
            <div class="search-container mb-4">
                <div class="row g-3">
                    <div class="col-md-6">
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-search"></i></span>
                            <input type="text" id="searchBooking" class="form-control" placeholder="Search by Booking Number" onkeyup="searchTable()">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-person-badge"></i></span>
                            <input type="text" id="searchCustomer" class="form-control" placeholder="Search by Customer ID" onkeyup="searchTable()">
                        </div>
                    </div>
                </div>
            </div>

            <!-- Booking Stats Summary -->
            <div class="row mb-4 g-3">
                <div class="col-md-3">
                    <div class="card bg-primary bg-opacity-10 border-0 h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-calendar-check text-primary" style="font-size: 2rem;"></i>
                            <h3 class="mt-2">${bookings.size()}</h3>
                            <p class="mb-0">Total Bookings</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card bg-success bg-opacity-10 border-0 h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-people text-success" style="font-size: 2rem;"></i>
                            <h3 class="mt-2">${registeredCustomers.size()}</h3>
                            <p class="mb-0">Customers</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card bg-warning bg-opacity-10 border-0 h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-car-front text-warning" style="font-size: 2rem;"></i>
                            <h3 class="mt-2">${availableCars.size()}</h3>
                            <p class="mb-0">Available Cars</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card bg-info bg-opacity-10 border-0 h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-person-badge text-info" style="font-size: 2rem;"></i>
                            <h3 class="mt-2">${availableDrivers.size()}</h3>
                            <p class="mb-0">Available Drivers</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Booking Table -->
            <div class="booking-table">
                <table class="table table-striped mb-0">
                    <thead class="table-header">
                    <tr>
                        <th><i class="bi bi-bookmark me-1"></i> Booking #</th>
                        <th><i class="bi bi-person me-1"></i> Customer</th>
                        <th><i class="bi bi-geo-alt me-1"></i> Destination</th>
                        <th><i class="bi bi-rulers me-1"></i> Distance</th>
                        <th><i class="bi bi-currency-dollar me-1"></i> Fare</th>
                        <th><i class="bi bi-car-front me-1"></i> Car</th>
                        <th><i class="bi bi-person-badge me-1"></i> Driver</th>
                        <th><i class="bi bi-gear me-1"></i> Actions</th>
                    </tr>
                    </thead>
                    <tbody id="bookingTableBody">
                    <c:forEach var="booking" items="${bookings}">
                        <tr>
                            <td class="fw-bold">${booking.bookingNumber}</td>
                            <td>
                                <span class="badge bg-primary bg-opacity-10 text-primary">
                                        ${booking.customer.registrationNumber}
                                </span>
                            </td>
                            <td>${booking.destination}</td>
                            <td>${booking.distance} km</td>
                            <td>LKR ${booking.fare}</td>
                            <td>
                                <span class="badge bg-warning bg-opacity-10 text-warning">
                                    ${booking.car.carId} - ${booking.car.licensePlate}
                                </span>
                            </td>
                            <td>
                                <span class="badge bg-info bg-opacity-10 text-info">
                                        ${booking.driver.driverId}
                                </span>
                            </td>
                            <td class="action-buttons">
                                <a href="deleteBooking?id=${booking.bookingNumber}" class="btn btn-danger btn-sm"
                                   onclick="return confirm('Are you sure you want to delete this booking?')">
                                    <i class="bi bi-trash"></i>
                                </a>
                                <a href="bookings?bookingNumber=${booking.bookingNumber}" class="btn btn-primary btn-sm">
                                    <i class="bi bi-printer"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Add Booking Modal -->
<div class="modal fade" id="addBookingModal" tabindex="-1" aria-labelledby="addBookingModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addBookingModalLabel"><i class="bi bi-plus-circle me-2"></i>Add New Booking</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="bookings" method="post" id="bookingForm">
                    <input type="hidden" name="action" value="add">

                    <div class="mb-3">
                        <label for="bookingNumber" class="form-label"><i class="bi bi-bookmark me-1"></i> Booking Number</label>
                        <input type="text" class="form-control" id="bookingNumber" name="bookingNumber" required>
                    </div>

                    <div class="mb-3">
                        <label for="customerRegistrationNumber" class="form-label"><i class="bi bi-person me-1"></i> Customer</label>
                        <select class="form-select" id="customerRegistrationNumber" name="customerRegistrationNumber" required>
                            <option value="" selected disabled>Select a customer</option>
                            <c:forEach var="customer" items="${registeredCustomers}">
                                <option value="${customer.registrationNumber}">${customer.registrationNumber} - ${customer.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="destination" class="form-label"><i class="bi bi-geo-alt me-1"></i> Destination</label>
                        <input type="text" class="form-control" id="destination" name="destination" required>
                    </div>

                    <div class="mb-3">
                        <label for="distance" class="form-label"><i class="bi bi-rulers me-1"></i> Distance (km)</label>
                        <input type="number" step="0.1" class="form-control" id="distance" name="distance" required
                               onchange="calculateFare()">
                    </div>

                    <div class="mb-3">
                        <label for="fare" class="form-label"><i class="bi bi-currency-dollar me-1"></i> Estimated Fare (LKR)</label>
                        <input type="text" class="form-control" id="fare" name="fare" readonly>
                    </div>

                    <div class="mb-3">
                        <label for="carId" class="form-label"><i class="bi bi-car-front me-1"></i> Select Car</label>
                        <select class="form-select" id="carId" name="carId" required>
                            <option value="" selected disabled>Select a car</option>
                            <c:forEach var="car" items="${availableCars}">
                                <option value="${car.carId}">${car.carId} - ${car.model} (${car.licensePlate})</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="driverId" class="form-label"><i class="bi bi-person-badge me-1"></i> Select Driver</label>
                        <select class="form-select" id="driverId" name="driverId" required>
                            <option value="" selected disabled>Select a driver</option>
                            <c:forEach var="driver" items="${availableDrivers}">
                                <option value="${driver.driverId}">${driver.driverId} - ${driver.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-check-circle me-2"></i> Add Booking
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript -->
<script>
    // Search function
    function searchTable() {
        let bookingInput = document.getElementById("searchBooking").value.toLowerCase();
        let customerInput = document.getElementById("searchCustomer").value.toLowerCase();
        let table = document.getElementById("bookingTableBody");
        let rows = table.getElementsByTagName("tr");

        for (let i = 0; i < rows.length; i++) {
            let bookingNumber = rows[i].getElementsByTagName("td")[0].innerText.toLowerCase();
            let customerId = rows[i].getElementsByTagName("td")[1].innerText.toLowerCase();

            if (bookingNumber.includes(bookingInput) && customerId.includes(customerInput)) {
                rows[i].style.display = "";
            } else {
                rows[i].style.display = "none";
            }
        }
    }

    function calculateFare() {
        const distance = parseFloat(document.getElementById("distance").value);
        if (!isNaN(distance)) {
            // Base fare + per km rate (sample calculation)
            const baseFare = 300;
            const perKmRate = 80;
            const estimatedFare = baseFare + (distance * perKmRate);
            document.getElementById("fare").value = Math.round(estimatedFare);
        } else {
            document.getElementById("fare").value = "";
        }
    }

    // Toast initialization
    document.addEventListener('DOMContentLoaded', function() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('success')) {
            // Show the toast
            const toast = new bootstrap.Toast(document.getElementById('bookingSuccessToast'), {
                autohide: true,
                delay: 5000
            });
            toast.show();

            // Highlight the newly added booking
            const bookingNumber = urlParams.get('bookingNumber');
            if (bookingNumber) {
                const rows = document.getElementById("bookingTableBody").getElementsByTagName("tr");
                for (let i = 0; i < rows.length; i++) {
                    const id = rows[i].getElementsByTagName("td")[0].innerText;
                    if (id === bookingNumber) {
                        rows[i].classList.add('new-booking');
                        // Scroll to the new booking
                        rows[i].scrollIntoView({ behavior: 'smooth', block: 'center' });
                        break;
                    }
                }
            }
        }
    });
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>