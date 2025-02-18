<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center">Customer Management</h1>
    <form action="customers" method="post" class="mt-4">
        <div class="mb-3">
            <label for="registrationNumber" class="form-label">Registration Number</label>
            <input type="text" class="form-control" id="registrationNumber" name="registrationNumber" required>
        </div>
        <div class="mb-3">
            <label for="name" class="form-label">Name</label>
            <input type="text" class="form-control" id="name" name="name" required>
        </div>
        <div class="mb-3">
            <label for="address" class="form-label">Address</label>
            <input type="text" class="form-control" id="address" name="address" required>
        </div>
        <div class="mb-3">
            <label for="nic" class="form-label">NIC</label>
            <input type="text" class="form-control" id="nic" name="nic" required>
        </div>
        <div class="mb-3">
            <label for="telephone" class="form-label">Telephone</label>
            <input type="text" class="form-control" id="telephone" name="telephone" required>
        </div>
        <button type="submit" class="btn btn-primary">Register Customer</button>
    </form>

    <h2 class="mt-5">Customer List</h2>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>Registration Number</th>
            <th>Name</th>
            <th>Address</th>
            <th>NIC</th>
            <th>Telephone</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="customer" items="${customers}">
            <tr>
                <td>${customer.registrationNumber}</td>
                <td>${customer.name}</td>
                <td>${customer.address}</td>
                <td>${customer.nic}</td>
                <td>${customer.telephone}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <c:if test="${param.success != null}">
        <div class="alert alert-success mt-3">Customer registered successfully!</div>
    </c:if>
    <c:if test="${param.error != null}">
        <div class="alert alert-danger mt-3">Error occurred while processing your request.</div>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>