package com.megacitycab.megacitycab.dao;

import com.megacitycab.megacitycab.model.Payment;
import com.megacitycab.megacitycab.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {

    private Connection connection;

    public PaymentDAO(Connection connection) {
        this.connection = connection;
    }

    // Add a new payment
    public void addPayment(Payment payment) throws SQLException {
        String sql = "INSERT INTO Payment (payment_id, customer_id, booking_id, amount, status) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, payment.getPaymentId());
            statement.setString(2, payment.getCustomerId());
            statement.setString(3, payment.getBookingNumber());
            statement.setDouble(5, payment.getAmount());
            statement.setString(6, payment.getStatus());
            statement.executeUpdate();
        }
    }

    // Get a payment by its ID
    public Payment getPaymentById(String paymentId) throws SQLException {
        String sql = "SELECT * FROM Payment WHERE payment_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, paymentId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapResultSetToPayment(resultSet);
                }
            }
        }
        return null;
    }

    // Get all payments
    public List<Payment> getAllPayments() throws SQLException {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT * FROM Payment";
        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                payments.add(mapResultSetToPayment(resultSet));
            }
        }
        return payments;
    }

    // Update payment status
    public void updatePaymentStatus(String paymentId, String status) throws SQLException {
        String sql = "UPDATE Payment SET status = ? WHERE payment_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, status);
            statement.setString(2, paymentId);
            statement.executeUpdate();
        }
    }

    // Delete a payment
    public void deletePayment(String paymentId) throws SQLException {
        String sql = "DELETE FROM Payment WHERE payment_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, paymentId);
            statement.executeUpdate();
        }
    }

    // Helper method to map the result set to a Payment object
    private Payment mapResultSetToPayment(ResultSet resultSet) throws SQLException {
        String paymentId = resultSet.getString("payment_id");
        String customerId = resultSet.getString("customer_id");
        String bookingNumber = resultSet.getString("booking_number");
        String carId = resultSet.getString("car_id");
        double amount = resultSet.getDouble("amount");
        String status = resultSet.getString("status");

        return new Payment(paymentId, customerId, bookingNumber, carId, amount, status);
    }
}
