<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Management - Mega City Cab</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5 p-4 bg-white rounded shadow">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <a href="dashboard.jsp" class="btn btn-outline-primary">
            <i class="bi bi-house-door-fill"></i> Home
        </a>
    </div>

    <h1 class="text-center">Booking Management</h1>

    <!-- 🔍 Search Box -->
    <div class="input-group mb-3">
        <input type="text" id="searchInput" class="form-control" placeholder="Search by Booking Number or Customer ID" onkeyup="searchTable()">
        <span class="input-group-text"><i class="bi bi-search"></i></span>
    </div>

    <div class="text-center my-3">
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBookingModal">
            Add New Booking
        </button>
    </div>

    <!-- Booking List -->
    <table class="table table-bordered table-striped text-center">
        <thead class="table-primary">
        <tr>
            <th>Booking Number</th>
            <th>Customer</th>
            <th>Destination</th>
            <th>Distance (km)</th>
            <th>Fare (LKR)</th>
            <th>Car</th>
            <th>Driver</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody id="bookingTableBody">
        <c:forEach var="booking" items="${bookings}">
            <tr>
                <td>${booking.bookingNumber}</td>
                <td>${booking.customer.registrationNumber}</td>
                <td>${booking.destination}</td>
                <td>${booking.distance}</td>
                <td>${booking.fare}</td>
                <td>${booking.car.carId}</td>
                <td>${booking.driver.driverId}</td>
                <td>
                    <a href="editBooking?id=${booking.bookingNumber}" class="btn btn-warning btn-sm">Edit</a>
                    <a href="deleteBooking?id=${booking.bookingNumber}" class="btn btn-danger btn-sm"
                       onclick="return confirm('Are you sure you want to delete this booking?')">Delete</a>
                    <button class="btn btn-success btn-sm" onclick="openPaymentModal('${booking.bookingNumber}', ${booking.fare})">Pay</button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- Add Booking Modal -->
<div class="modal fade" id="addBookingModal" tabindex="-1" aria-labelledby="addBookingModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addBookingModalLabel">Add New Booking</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="bookings" method="post">
                    <input type="hidden" name="action" value="add">

                    <div class="mb-3">
                        <label for="bookingNumber" class="form-label">Booking Number</label>
                        <input type="text" class="form-control" id="bookingNumber" name="bookingNumber" required>
                    </div>

                    <div class="mb-3">
                        <label for="customerRegistrationNumber" class="form-label">Customer Registration Number</label>
                        <select class="form-select" id="customerRegistrationNumber" name="customerRegistrationNumber" required>
                            <c:forEach var="customer" items="${registeredCustomers}">
                                <option value="${customer.registrationNumber}">${customer.registrationNumber} - ${customer.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="destination" class="form-label">Destination</label>
                        <input type="text" class="form-control" id="destination" name="destination" required>
                    </div>

                    <div class="mb-3">
                        <label for="distance" class="form-label">Distance (km)</label>
                        <input type="number" step="0.1" class="form-control" id="distance" name="distance" required>
                    </div>

                    <div class="mb-3">
                        <label for="carId" class="form-label">Select Car</label>
                        <select class="form-select" id="carId" name="carId" required>
                            <c:forEach var="car" items="${availableCars}">
                                <option value="${car.carId}">${car.carId} - ${car.model} (${car.licensePlate})</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="driverId" class="form-label">Select Driver</label>
                        <select class="form-select" id="driverId" name="driverId" required>
                            <c:forEach var="driver" items="${availableDrivers}">
                                <option value="${driver.driverId}">${driver.driverId} - ${driver.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-primary">Add Booking</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Add Payment Modal -->
<div class="modal fade" id="paymentModal" tabindex="-1" aria-labelledby="paymentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="paymentModalLabel">Make Payment</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="payment" method="post">
                    <input type="hidden" name="action" value="pay">
                    <input type="hidden" name="bookingNumber" id="paymentBookingNumber">

                    <div class="mb-3">
                        <label for="amount" class="form-label">Amount (LKR)</label>
                        <input type="number" class="form-control" id="amount" name="amount" required>
                    </div>

                    <button type="submit" class="btn btn-success">Make Payment</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript for Search Functionality -->
<script>
    function searchTable() {
        let input = document.getElementById("searchInput").value.toLowerCase();
        let table = document.getElementById("bookingTableBody");
        let rows = table.getElementsByTagName("tr");

        for (let i = 0; i < rows.length; i++) {
            let bookingNumber = rows[i].getElementsByTagName("td")[0].innerText.toLowerCase();
            let customerId = rows[i].getElementsByTagName("td")[1].innerText.toLowerCase();

            if (bookingNumber.includes(input) || customerId.includes(input)) {
                rows[i].style.display = "";
            } else {
                rows[i].style.display = "none";
            }
        }
    }

    function openPaymentModal(bookingNumber, fare) {
        document.getElementById('paymentBookingNumber').value = bookingNumber;
        document.getElementById('amount').value = fare;
        new bootstrap.Modal(document.getElementById('paymentModal')).show();
    }
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
