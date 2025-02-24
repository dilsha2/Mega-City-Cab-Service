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

    <!-- Success and Error Alerts -->
    <div id="successAlert" class="alert alert-success d-none" role="alert">
        ✅ Operation completed successfully!
    </div>
    <div id="errorAlert" class="alert alert-danger d-none" role="alert">
        ❌ Error occurred while processing your request.
    </div>

    <h1 class="text-center">Booking Management</h1>

    <div class="text-center my-3">
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBookingModal">
            Add New Booking
        </button>
    </div>

    <!-- Search Filters -->
    <div class="row my-3">
        <div class="col-md-6">
            <input type="text" id="searchBookingId" class="form-control" placeholder="Search by Booking ID...">
        </div>
        <div class="col-md-6">
            <input type="text" id="searchCustomerId" class="form-control" placeholder="Search by Customer ID...">
        </div>
    </div>

    <!-- Booking List -->
    <h2 class="mt-5">Booking List</h2>
    <table class="table table-bordered table-striped text-center">
        <thead class="table-primary">
        <tr>
            <th>Booking Number</th>
            <th>Customer</th>
            <th>Destination</th>
            <th>Distance (km)</th>
            <th>Fare (LKR)</th>
            <th>Car</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody id="bookingTableBody">
        <c:forEach var="booking" items="${bookings}">
            <tr>
                <td class="booking-id">${booking.bookingNumber}</td>
                <td class="customer-id">${booking.customer.registrationNumber}</td>
                <td>${booking.destination}</td>
                <td>${booking.distance}</td>
                <td>${booking.fare}</td>
                <td>${booking.car.carId}</td>
                <td>
                    <a href="editBooking?id=${booking.bookingNumber}" class="btn btn-warning btn-sm">Edit</a>
                    <a href="deleteBooking?id=${booking.bookingNumber}" class="btn btn-danger btn-sm"
                       onclick="return confirm('Are you sure you want to delete this booking?')">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script>
    function filterTable() {
        let bookingInput = document.getElementById("searchBookingId").value.toLowerCase();
        let customerInput = document.getElementById("searchCustomerId").value.toLowerCase();
        let tableRows = document.querySelectorAll("#bookingTableBody tr");

        tableRows.forEach(row => {
            let bookingId = row.querySelector(".booking-id").textContent.toLowerCase();
            let customerId = row.querySelector(".customer-id").textContent.toLowerCase();

            if (bookingId.includes(bookingInput) && customerId.includes(customerInput)) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        });
    }

    document.getElementById("searchBookingId").addEventListener("input", filterTable);
    document.getElementById("searchCustomerId").addEventListener("input", filterTable);
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
