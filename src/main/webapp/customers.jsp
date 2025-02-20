<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Management</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .container {
            margin-top: 30px;
        }
    </style>
</head>
<body>

<div class="container">
    <h1 class="text-center mb-4">Customer Management</h1>

    <!-- Add New Customer Button -->
    <div class="text-center">
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCustomerModal">Add New Customer
        </button>
    </div>

    <!-- Customer List -->
    <h2 class="text-center mt-4">Customer List</h2>
    <div class="table-responsive">
        <table class="table table-striped table-hover mt-3">
            <thead class="table-primary">
            <tr>
                <th>Registration Number</th>
                <th>Name</th>
                <th>Address</th>
                <th>NIC</th>
                <th>Telephone</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <!-- Loop through the customers list and display customer data -->
            <c:forEach var="customer" items="${customers}">
                <tr>
                    <td>${customer.registrationNumber}</td>
                    <td>${customer.name}</td>
                    <td>${customer.address}</td>
                    <td>${customer.nic}</td>
                    <td>${customer.telephone}</td>
                    <td>
                        <!-- Update Button -->
                        <button class="btn btn-warning btn-sm" data-bs-toggle="modal"
                                data-bs-target="#updateCustomerModal${customer.registrationNumber}">
                            Update
                        </button>
                        <!-- Delete Button -->
                        <form action="customers" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="registrationNumber" value="${customer.registrationNumber}">
                            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                        </form>
                    </td>
                </tr>

                <!-- Update Modal for Each Customer -->
                <div class="modal fade" id="updateCustomerModal${customer.registrationNumber}" tabindex="-1"
                     aria-labelledby="updateCustomerModalLabel${customer.registrationNumber}" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="updateCustomerModalLabel${customer.registrationNumber}">
                                    Update Customer</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="customers" method="post">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="registrationNumber"
                                           value="${customer.registrationNumber}">
                                    <div class="mb-3">
                                        <label for="name" class="form-label">Name</label>
                                        <input type="text" id="name" name="name" class="form-control"
                                               value="${customer.name}" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="address" class="form-label">Address</label>
                                        <input type="text" id="address" name="address" class="form-control"
                                               value="${customer.address}" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="nic" class="form-label">NIC</label>
                                        <input type="text" id="nic" name="nic" class="form-control"
                                               value="${customer.nic}" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="telephone" class="form-label">Telephone</label>
                                        <input type="text" id="telephone" name="telephone" class="form-control"
                                               value="${customer.telephone}" required>
                                    </div>
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-success">Update Customer</button>
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

<!-- Add Customer Modal -->
<div class="modal fade" id="addCustomerModal" tabindex="-1" aria-labelledby="addCustomerModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addCustomerModalLabel">Add New Customer</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="customers" method="post">
                    <input type="hidden" name="action" value="add">
                    <div class="mb-3">
                        <label for="registrationNumber" class="form-label">Registration Number</label>
                        <input type="text" id="registrationNumber" name="registrationNumber" class="form-control"
                               required>
                    </div>
                    <div class="mb-3">
                        <label for="name" class="form-label">Name</label>
                        <input type="text" id="name" name="name" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="address" class="form-label">Address</label>
                        <input type="text" id="address" name="address" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="nic" class="form-label">NIC</label>
                        <input type="text" id="nic" name="nic" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="telephone" class="form-label">Telephone</label>
                        <input type="text" id="telephone" name="telephone" class="form-control" required>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-success">Register Customer</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS (for modal functionality) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    window.onload = function () {
        getUrlParams();
        logTableData();
    };

    // Function to extract query parameters and show alerts
    function getUrlParams() {
        const params = new URLSearchParams(window.location.search);
        if (params.has("success")) {
            alert("Operation completed successfully!");
        } else if (params.has("error")) {
            alert("Error occurred while processing your request.");
        }
    }

    // Function to log table data
    function logTableData() {
        const tableRows = document.querySelectorAll("tbody tr");

        console.log("Logging Customer Table Data:");

        tableRows.forEach((row, index) => {
            const columns = row.querySelectorAll("td");
            const customerData = {
                registrationNumber: columns[0]?.textContent.trim(),
                name: columns[1]?.textContent.trim(),
                address: columns[2]?.textContent.trim(),
                nic: columns[3]?.textContent.trim(),
                telephone: columns[4]?.textContent.trim()
            };
            console.log(`Customer ${index + 1}:`, customerData);
        });
    }
</script>

</body>
</html>