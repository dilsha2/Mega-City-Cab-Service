package com.megacitycab.megacitycab.dao;

import com.megacitycab.megacitycab.model.Customer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {
    private final Connection connection;

    public CustomerDAO(Connection connection) {
        this.connection = connection;
    }

    public void addCustomer(Customer customer) throws SQLException {
        String sql = "INSERT INTO customers (registration_number, name, address, nic, telephone) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, customer.getRegistrationNumber());
            statement.setString(2, customer.getName());
            statement.setString(3, customer.getAddress());
            statement.setString(4, customer.getNic());
            statement.setString(5, customer.getTelephone());
            statement.executeUpdate();
        }
    }

    public List<Customer> getAllCustomers() throws SQLException {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers";
        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Customer customer = new Customer();
                customer.setRegistrationNumber(resultSet.getString("registration_number"));
                customer.setName(resultSet.getString("name"));
                customer.setAddress(resultSet.getString("address"));
                customer.setNic(resultSet.getString("nic"));
                customer.setTelephone(resultSet.getString("telephone"));
                customers.add(customer);
            }
        }
        return customers;
    }
}