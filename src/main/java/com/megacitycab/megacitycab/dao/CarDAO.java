package com.megacitycab.megacitycab.dao;

import com.megacitycab.megacitycab.model.Car;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CarDAO {
    private final Connection connection;

    public CarDAO(Connection connection) {
        this.connection = connection;
    }

    public void addCar(Car car) throws SQLException {
        String sql = "INSERT INTO cars (car_id, model, license_plate) VALUES (?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, car.getCarId());
            statement.setString(2, car.getModel());
            statement.setString(3, car.getLicensePlate());
            statement.executeUpdate();
        }
    }

    public List<Car> getAllCars() throws SQLException {
        List<Car> cars = new ArrayList<>();
        String sql = "SELECT * FROM cars";
        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Car car = new Car();
                car.setCarId(resultSet.getString("car_id"));
                car.setModel(resultSet.getString("model"));
                car.setLicensePlate(resultSet.getString("license_plate"));
                cars.add(car);
            }
        }
        return cars;
    }

    public void updateCar(Car car) throws SQLException {
        String sql = "UPDATE cars SET model = ?, license_plate = ? WHERE car_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, car.getModel());
            statement.setString(2, car.getLicensePlate());
            statement.setString(3, car.getCarId());
            statement.executeUpdate();
        }
    }

    public void deleteCar(String carId) throws SQLException {
        String sql = "DELETE FROM cars WHERE car_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, carId);
            statement.executeUpdate();
        }
    }
}