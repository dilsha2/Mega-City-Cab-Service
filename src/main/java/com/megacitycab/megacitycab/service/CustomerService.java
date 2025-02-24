package com.megacitycab.megacitycab.service;


import com.megacitycab.megacitycab.dao.CustomerDAO;
import com.megacitycab.megacitycab.model.Car;
import com.megacitycab.megacitycab.model.Customer;

import java.sql.SQLException;
import java.util.List;

public class CustomerService {
    private final CustomerDAO customerDAO;

    public CustomerService(CustomerDAO customerDAO) {
        this.customerDAO = customerDAO;
    }

    public void registerCustomer(Customer customer) throws SQLException {
        customerDAO.addCustomer(customer);
    }

    public List<Customer> getAllCustomers() throws SQLException {
        return customerDAO.getAllCustomers();
    }

    public void updateCustomer(Customer customer) throws SQLException {
        customerDAO.updateCustomer(customer);
    }

    public void deleteCustomer(String registrationNumber) throws SQLException {
        customerDAO.deleteCustomer(registrationNumber);
    }

    public Customer getCustomerByRegistrationNumber(String customerId) throws SQLException {
        return customerDAO.getCustomerByRegistrationNumber(customerId);
    }
}