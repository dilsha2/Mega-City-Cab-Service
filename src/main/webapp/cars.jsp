<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Car Management - Mega City Cab</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5 p-4 bg-white rounded shadow">
    <h1 class="text-center">Car Management</h1>

    <!-- Success and Error Alerts -->
    <div id="successAlert" class="alert alert-success d-none" role="alert">
        ✅ Operation completed successfully!
    </div>
    <div id="errorAlert" class="alert alert-danger d-none" role="alert">
        ❌ Error occurred while processing your request.
    </div>

    <!-- Add New Car Button -->
    <div class="text-center my-3">
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCarModal">
            Add New Car
        </button>
    </div>

    <!-- Car List -->
    <h2 class="mt-4">Car List</h2>
    <div class="table-responsive">
        <table class="table table-striped">
            <thead class="table-primary">
            <tr>
                <th>Car ID</th>
                <th>Model</th>
                <th>License Plate</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="car" items="${cars}">
                <tr>
                    <td>${car.carId}</td>
                    <td>${car.model}</td>
                    <td>${car.licensePlate}</td>
                    <td>
                        <!-- Update Button -->
                        <button class="btn btn-warning btn-sm" data-bs-toggle="modal"
                                data-bs-target="#updateCarModal${car.carId}">
                            Update
                        </button>
                        <!-- Delete Button -->
                        <form action="cars" method="post" class="d-inline">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="carId" value="${car.carId}">
                            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                        </form>
                    </td>
                </tr>

                <!-- Update Modal -->
                <div class="modal fade" id="updateCarModal${car.carId}" tabindex="-1"
                     aria-labelledby="updateCarModalLabel${car.carId}" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="updateCarModalLabel${car.carId}">Update Car</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="cars" method="post">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="carId" value="${car.carId}">
                                    <div class="mb-3">
                                        <label for="model${car.carId}" class="form-label">Model</label>
                                        <input type="text" id="model${car.carId}" name="model" class="form-control" value="${car.model}" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="licensePlate${car.carId}" class="form-label">License Plate</label>
                                        <input type="text" id="licensePlate${car.carId}" name="licensePlate" class="form-control" value="${car.licensePlate}" required>
                                    </div>
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-success">Update Car</button>
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

<!-- Add Car Modal -->
<div class="modal fade" id="addCarModal" tabindex="-1" aria-labelledby="addCarModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addCarModalLabel">Add New Car</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="cars" method="post">
                    <input type="hidden" name="action" value="add">
                    <div class="mb-3">
                        <label for="carId" class="form-label">Car ID</label>
                        <input type="text" class="form-control" id="carId" name="carId" required>
                    </div>
                    <div class="mb-3">
                        <label for="model" class="form-label">Model</label>
                        <input type="text" class="form-control" id="model" name="model" required>
                    </div>
                    <div class="mb-3">
                        <label for="licensePlate" class="form-label">License Plate</label>
                        <input type="text" class="form-control" id="licensePlate" name="licensePlate" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Add Car</button>
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
    window.onload = checkUrlParams;
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
