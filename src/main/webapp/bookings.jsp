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
    <h1 class="text-center">Booking Management</h1>

    <!-- Success and Error Alerts -->
    <div id="successAlert" class="alert alert-success d-none" role="alert">
        ✅ Booking added successfully!
    </div>
    <div id="errorAlert" class="alert alert-danger d-none" role="alert">
        ❌ Error occurred while adding the booking.
    </div>

    <!-- Add New Booking Button (Centered) -->
    <div class="text-center my-3">
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBookingModal">
            Add New Booking
        </button>
    </div>

    <!-- Add Booking Modal -->
    <div class="modal fade" id="addBookingModal" tabindex="-1" aria-labelledby="addBookingModalLabel"
         aria-hidden="true">
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
                            <label for="customerName" class="form-label">Customer Name</label>
                            <input type="text" class="form-control" id="customerName" name="customerName" required>
                        </div>
                        <div class="mb-3">
                            <label for="destination" class="form-label">Destination</label>
                            <input type="text" class="form-control" id="destination" name="destination" required>
                        </div>
                        <div class="mb-3">
                            <label for="distance" class="form-label">Distance (km)</label>
                            <input type="number" class="form-control" id="distance" name="distance" step="0.1" required>
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-success">Add Booking</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Booking List -->
    <h2 class="mt-5">Booking List</h2>
    <div class="table-responsive">
        <table class="table table-bordered table-striped text-center">
            <thead class="table-primary">
            <tr>
                <th>Booking Number</th>
                <th>Customer Name</th>
                <th>Destination</th>
                <th>Distance (km)</th>
                <th>Fare (LKR)</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="booking" items="${bookings}">
                <tr>
                    <td>${booking.bookingNumber}</td>
                    <td>${booking.customerName}</td>
                    <td>${booking.destination}</td>
                    <td>${booking.distance}</td>
                    <td>${booking.fare}</td>
                    <td>
                        <!-- Delete Button -->
                        <form action="bookings" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="bookingNumber" value="${booking.bookingNumber}">
                            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
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

    window.onload = checkUrlParams;
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
