package com.megacitycab.megacitycab.dao;

import com.megacitycab.megacitycab.enums.Status;
import com.megacitycab.megacitycab.model.Driver;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DriverDAO {
    private final Connection connection;

    public DriverDAO(Connection connection) {
        this.connection = connection;
    }

    public void addDriver(Driver driver) throws SQLException {
        String sql = "INSERT INTO drivers (driver_id, name, license_number, status) VALUES (?, ?, ?,?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, driver.getDriverId());
            statement.setString(2, driver.getName());
            statement.setString(3, driver.getLicenseNumber());
            statement.setString(4, Status.AVAILABLE.name());
            statement.executeUpdate();
        }
    }

    public List<Driver> getAllDrivers() throws SQLException {
        List<Driver> drivers = new ArrayList<>();
        String sql = "SELECT * FROM drivers";
        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Driver driver = new Driver();
                driver.setDriverId(resultSet.getString("driver_id"));
                driver.setName(resultSet.getString("name"));
                driver.setLicenseNumber(resultSet.getString("license_number"));
                driver.setStatus(resultSet.getString("status"));
                drivers.add(driver);
            }
        }
        return drivers;
    }
    public List<Driver> getAllDriversWhereStatus() throws SQLException {
        List<Driver> drivers = new ArrayList<>();
        String sql = "SELECT * FROM drivers WHERE status = ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            // Set the status parameter before executing the query
            statement.setString(1, Status.AVAILABLE.name());

            // Execute the query and process the result
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Driver driver = new Driver();
                    driver.setDriverId(resultSet.getString("driver_id"));
                    driver.setName(resultSet.getString("name"));
                    driver.setLicenseNumber(resultSet.getString("license_number"));
                    drivers.add(driver);
                }
            }
        }
        return drivers;
    }


    public void updateDriver(Driver driver) throws SQLException {
        String sql = "UPDATE drivers SET name = ?, license_number = ? WHERE driver_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, driver.getName());
            statement.setString(2, driver.getLicenseNumber());
            statement.setString(3, driver.getDriverId());
            statement.executeUpdate();
        }
    }

    public void deleteDriver(String driverId) throws SQLException {
        String sql = "DELETE FROM drivers WHERE driver_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, driverId);
            statement.executeUpdate();
        }
    }

    public void updateDriverStatus(String driverId, String status) throws SQLException {
        String sql = "UPDATE drivers SET status = ? WHERE driver_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, status);
            statement.setString(2, driverId);
            statement.executeUpdate();
        }
    }

    public Driver getDriverById(String driverId) throws SQLException {
        String query = "SELECT * FROM drivers WHERE driver_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, driverId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String id = rs.getString("driver_id");
                String name = rs.getString("name");
                String licenseNumber = rs.getString("license_number");
                String status = rs.getString("status");

                return new Driver(id, name, licenseNumber, status);
            }
        }
        return null;  // Return null if the car is not found
    }
}