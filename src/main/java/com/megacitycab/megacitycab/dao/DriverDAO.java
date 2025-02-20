package com.megacitycab.megacitycab.dao;

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
        String sql = "INSERT INTO drivers (driver_id, name, license_number) VALUES (?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, driver.getDriverId());
            statement.setString(2, driver.getName());
            statement.setString(3, driver.getLicenseNumber());
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
                drivers.add(driver);
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
}