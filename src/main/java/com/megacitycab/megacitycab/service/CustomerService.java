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

    public void registerCustomer(String registrationNumber, String name, String address, String nic, String telephone) throws SQLException {
        Customer customer = new Customer();
        customer.setRegistrationNumber(registrationNumber);
        customer.setName(name);
        customer.setAddress(address);
        customer.setNic(nic);
        customer.setTelephone(telephone);

        customerDAO.addCustomer(customer);
    }

    public List<Customer> getAllCustomers() throws SQLException {
        return customerDAO.getAllCustomers();
    }

    public void updateCustomer(String registrationNumber, String name, String address, String nic, String telephone) throws SQLException {

        Customer customer = new Customer();
        customer.setRegistrationNumber(registrationNumber);
        customer.setName(name);
        customer.setAddress(address);
        customer.setNic(nic);
        customer.setTelephone(telephone);

        customerDAO.updateCustomer(customer);
    }

    public void deleteCustomer(String registrationNumber) throws SQLException {
        customerDAO.deleteCustomer(registrationNumber);
    }

    public Customer getCustomerByRegistrationNumber(String customerId) throws SQLException {
        return customerDAO.getCustomerByRegistrationNumber(customerId);
    }
}