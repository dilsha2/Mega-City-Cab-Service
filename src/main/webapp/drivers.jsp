<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Management - Mega City Cab</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5 p-4 bg-white rounded shadow">
    <h1 class="text-center mb-4">Driver Management</h1>

    <!-- Success and Error Alerts -->
    <div id="successAlert" class="alert alert-success d-none" role="alert">
        ✅ Operation completed successfully!
    </div>
    <div id="errorAlert" class="alert alert-danger d-none" role="alert">
        ❌ Error occurred while processing your request.
    </div>

    <!-- Add New Driver Button (Centered) -->
    <div class="text-center my-3">
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addDriverModal">
            Add New Driver
        </button>
    </div>

    <!-- Add Driver Modal -->
    <div class="modal fade" id="addDriverModal" tabindex="-1" aria-labelledby="addDriverModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addDriverModalLabel">Add New Driver</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="drivers" method="post">
                        <input type="hidden" name="action" value="add">
                        <div class="mb-3">
                            <label for="driverId" class="form-label">Driver ID</label>
                            <input type="text" class="form-control" id="driverId" name="driverId" required>
                        </div>
                        <div class="mb-3">
                            <label for="name" class="form-label">Name</label>
                            <input type="text" class="form-control" id="name" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="licenseNumber" class="form-label">License Number</label>
                            <input type="text" class="form-control" id="licenseNumber" name="licenseNumber" required>
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-success">Add Driver</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Driver List -->
    <h2 class="mt-5">Driver List</h2>
    <div class="table-responsive">
        <table class="table table-bordered table-striped text-center">
            <thead class="table-primary">
            <tr>
                <th>Driver ID</th>
                <th>Name</th>
                <th>License Number</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="driver" items="${drivers}">
                <tr>
                    <td>${driver.driverId}</td>
                    <td>${driver.name}</td>
                    <td>${driver.licenseNumber}</td>
                    <td>
                        <!-- Update Button -->
                        <button class="btn btn-warning btn-sm" data-bs-toggle="modal"
                                data-bs-target="#updateDriverModal${driver.driverId}">
                            Update
                        </button>
                        <!-- Delete Button -->
                        <form action="drivers" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="driverId" value="${driver.driverId}">
                            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                        </form>
                    </td>
                </tr>

                <!-- Update Modal for Each Driver -->
                <div class="modal fade" id="updateDriverModal${driver.driverId}" tabindex="-1"
                     aria-labelledby="updateDriverModalLabel${driver.driverId}" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="updateDriverModalLabel${driver.driverId}">Update Driver</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="drivers" method="post">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="driverId" value="${driver.driverId}">
                                    <div class="mb-3">
                                        <label for="name" class="form-label">Name</label>
                                        <input type="text" name="name" class="form-control" value="${driver.name}"
                                               required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="licenseNumber" class="form-label">License Number</label>
                                        <input type="text" name="licenseNumber" class="form-control"
                                               value="${driver.licenseNumber}" required>
                                    </div>
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-success">Update Driver</button>
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
