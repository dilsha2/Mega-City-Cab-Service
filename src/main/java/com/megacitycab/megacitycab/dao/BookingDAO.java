package com.megacitycab.megacitycab.dao;

import com.megacitycab.megacitycab.model.Booking;
import com.megacitycab.megacitycab.model.Car;
import com.megacitycab.megacitycab.model.Customer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {
    private final Connection connection;

    public BookingDAO(Connection connection) {
        this.connection = connection;
    }

    public void addBooking(Booking booking) throws SQLException {
        String sql = "INSERT INTO bookings (booking_number, customer_id, destination, distance, fare, car_id) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, booking.getBookingNumber());
            statement.setString(2, booking.getCustomer().getRegistrationNumber());  // Customer ID
            statement.setString(3, booking.getDestination());
            statement.setDouble(4, booking.getDistance());
            statement.setDouble(5, booking.getFare());
            statement.setString(6, booking.getCar().getCarId());
            statement.executeUpdate();
        }

        // Insert only one car
        String carSql = "INSERT INTO booking_cars (booking_number, car_id, customer_id) VALUES (?, ?, ?)";
        try (PreparedStatement carStatement = connection.prepareStatement(carSql)) {
            Car car = booking.getCar();
            carStatement.setString(1, booking.getBookingNumber());
            carStatement.setString(2, car.getCarId());
            carStatement.setString(3, booking.getCustomer().getRegistrationNumber());
            carStatement.executeUpdate();
        }
    }


    public List<Booking> getAllBookings() throws SQLException {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings";
        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Booking booking = new Booking();
                booking.setBookingNumber(resultSet.getString("booking_number"));
                booking.setCustomer(new Customer(resultSet.getString("customer_id")));  // Get customer by ID
                booking.setDestination(resultSet.getString("destination"));
                booking.setDistance(resultSet.getDouble("distance"));
                booking.setFare(resultSet.getDouble("fare"));

                // Set the single car for the booking
                String carId = resultSet.getString("car_id");
                booking.setCar(new Car(carId));

                System.out.println("car " + carId);
                System.out.println("customer " + booking.getCustomer().toString());

                bookings.add(booking);
            }
        }
        return bookings;
    }


    private Car getCarByBookingNumber(String bookingNumber) throws SQLException {
        Car car = null;
        String sql = "SELECT car_id FROM booking_cars WHERE booking_number = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, bookingNumber);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    String carId = resultSet.getString("car_id");
                    car = new Car(carId);
                }
            }
        }
        return car;
    }


    public void updateBooking(Booking booking) throws SQLException {
        String sql = "UPDATE bookings SET customer_id = ?, destination = ?, distance = ?, fare = ? WHERE booking_number = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, booking.getCustomer().getRegistrationNumber());
            statement.setString(2, booking.getDestination());
            statement.setDouble(3, booking.getDistance());
            statement.setDouble(4, booking.getFare());
            statement.setString(5, booking.getBookingNumber());
            statement.executeUpdate();
        }

        // Update associated car (delete old and insert new one)
        String deleteCarsSql = "DELETE FROM booking_cars WHERE booking_number = ?";
        try (PreparedStatement deleteStatement = connection.prepareStatement(deleteCarsSql)) {
            deleteStatement.setString(1, booking.getBookingNumber());
            deleteStatement.executeUpdate();
        }

        // Insert the new car (only one)
        String insertCarsSql = "INSERT INTO booking_cars (booking_number, car_id) VALUES (?, ?)";
        try (PreparedStatement carStatement = connection.prepareStatement(insertCarsSql)) {
            Car car = booking.getCar(); // Only one car
            carStatement.setString(1, booking.getBookingNumber());
            carStatement.setString(2, car.getCarId());
            carStatement.executeUpdate();
        }
    }

    public void deleteBooking(String bookingNumber) throws SQLException {
        String sql = "DELETE FROM bookings WHERE booking_number = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, bookingNumber);
            statement.executeUpdate();
        }

        // Delete cars associated with the booking
        String deleteCarsSql = "DELETE FROM booking_cars WHERE booking_number = ?";
        try (PreparedStatement deleteStatement = connection.prepareStatement(deleteCarsSql)) {
            deleteStatement.setString(1, bookingNumber);
            deleteStatement.executeUpdate();
        }
    }
}