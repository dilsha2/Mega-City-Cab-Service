package com.megacitycab.megacitycab.dao;

import com.megacitycab.megacitycab.model.OrderDetails;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class OrderDetailsDAO {
        private final Connection connection;

        public OrderDetailsDAO(Connection connection) {
            this.connection = connection;
        }

        public void addOrderDetails(OrderDetails orderDetails) throws SQLException {
            String sql = "INSERT INTO order_details (order_id, booking_number, car_id, customer_id) VALUES (?, ?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, orderDetails.getOrderId());
                statement.setString(2, orderDetails.getBooking().getBookingNumber());
                statement.setString(3, orderDetails.getCar().getCarId());
                statement.setString(4, orderDetails.getCustomer().getRegistrationNumber());
                statement.executeUpdate();
            }
        }
    }