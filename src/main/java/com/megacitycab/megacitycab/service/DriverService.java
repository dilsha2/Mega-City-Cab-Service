package com.megacitycab.megacitycab.service;


import com.megacitycab.megacitycab.dao.DriverDAO;
import com.megacitycab.megacitycab.model.Car;
import com.megacitycab.megacitycab.model.Driver;

import java.sql.SQLException;
import java.util.List;

public class DriverService {
    private final DriverDAO driverDAO;

    public DriverService(DriverDAO driverDAO) {
        this.driverDAO = driverDAO;
    }

    public void addDriver(Driver driver) throws SQLException {
        driverDAO.addDriver(driver);
    }

    public List<Driver> getAllDrivers() throws SQLException {
        return driverDAO.getAllDrivers();
    }

    public void updateDriver(Driver driver) throws SQLException {
        driverDAO.updateDriver(driver);
    }

    public void deleteDriver(String driverId) throws SQLException {
        driverDAO.deleteDriver(driverId);
    }
}