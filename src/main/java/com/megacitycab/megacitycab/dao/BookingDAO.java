package com.megacitycab.megacitycab.dao;

import com.megacitycab.megacitycab.model.Booking;

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
        String sql = "INSERT INTO bookings (booking_number, customer_name, destination, distance, fare) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, booking.getBookingNumber());
            statement.setString(2, booking.getCustomerName());
            statement.setString(3, booking.getDestination());
            statement.setDouble(4, booking.getDistance());
            statement.setDouble(5, booking.getFare());
            statement.executeUpdate();
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
                booking.setCustomerName(resultSet.getString("customer_name"));
                booking.setDestination(resultSet.getString("destination"));
                booking.setDistance(resultSet.getDouble("distance"));
                booking.setFare(resultSet.getDouble("fare"));
                bookings.add(booking);
            }
        }
        return bookings;
    }

    public void updateBooking(Booking booking) throws SQLException {
        String sql = "UPDATE bookings SET customer_name = ?, destination = ?, distance = ?, fare = ? WHERE booking_number = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, booking.getCustomerName());
            statement.setString(2, booking.getDestination());
            statement.setDouble(3, booking.getDistance());
            statement.setDouble(4, booking.getFare());
            statement.setString(5, booking.getBookingNumber());
            statement.executeUpdate();
        }
    }

    public void deleteBooking(String bookingNumber) throws SQLException {
        String sql = "DELETE FROM bookings WHERE booking_number = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, bookingNumber);
            statement.executeUpdate();
        }
    }
}