package com.megacitycab.megacitycab.service;

import com.megacitycab.megacitycab.dao.CarDAO;
import com.megacitycab.megacitycab.model.Car;

import java.sql.SQLException;
import java.util.List;

public class CarService {
    private final CarDAO carDAO;

    public CarService(CarDAO carDAO) {
        this.carDAO = carDAO;
    }

    public void addCar(Car car) throws SQLException {
        carDAO.addCar(car);
    }

    public List<Car> getAllCars() throws SQLException {
        return carDAO.getAllCars();
    }

    public void updateCar(Car car) throws SQLException {
        carDAO.updateCar(car);
    }

    public void deleteCar(String carId) throws SQLException {
         carDAO.deleteCar(carId);
    }

    public Car getCarById(String carId) throws SQLException {
        return carDAO.getCarById(carId);
    }
}