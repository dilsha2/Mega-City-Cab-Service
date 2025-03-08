package com.megacitycab.megacitycab.service;


import com.megacitycab.megacitycab.enums.Status;
import com.megacitycab.megacitycab.dao.DriverDAO;
import com.megacitycab.megacitycab.model.Driver;

import java.sql.SQLException;
import java.util.List;

public class DriverService {
    private final DriverDAO driverDAO;

    public DriverService(DriverDAO driverDAO) {
        this.driverDAO = driverDAO;
    }

    public void addDriver(String driverId, String name, String licenseNumber) throws SQLException {

        Driver driver = new Driver();
        driver.setDriverId(driverId);
        driver.setName(name);
        driver.setLicenseNumber(licenseNumber);
        driver.setStatus(Status.AVAILABLE.name());
        driverDAO.addDriver(driver);
    }

    public List<Driver> getAllDrivers() throws SQLException {
        return driverDAO.getAllDrivers();
    }

    public List<Driver> getAllDriversWhereStatus() throws SQLException {
        return driverDAO.getAllDriversWhereStatus();
    }

    public void updateDriver(Driver driver) throws SQLException {
        driverDAO.updateDriver(driver);
    }

    public void deleteDriver(String driverId) throws SQLException {
        driverDAO.deleteDriver(driverId);
    }

    public void updateDriverStatus(String driverId, String status) throws SQLException {
        driverDAO.updateDriverStatus(driverId, status);
    }

    public Driver getDriverById(String driverId) throws SQLException {
        return driverDAO.getDriverById(driverId);
    }
}