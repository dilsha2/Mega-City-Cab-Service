/**
 * Created By Dilsha Prasanna
 * Date : 2/17/2025
 * Time : 7:46 PM
 * Project Name : Mega City Cab
 */

package com.megacitycab.megacitycab.controller;

import com.megacitycab.megacitycab.dao.CustomerDAO;
import com.megacitycab.megacitycab.model.Customer;
import com.megacitycab.megacitycab.service.CustomerService;
import com.megacitycab.megacitycab.util.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/customers")
public class CustomerServlet extends HttpServlet {
    private CustomerService customerService;

    public CustomerServlet() {
        super();
    }

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DBUtil.getConnection();
            customerService = new CustomerService(new CustomerDAO(connection));
        } catch (SQLException e) {
            throw new ServletException("Unable to connect to database", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action"); // Determine the action (add, update, delete)

        if ("add".equals(action)) {
            // Handle Add Customer
            handleAddCustomer(request, response);
        } else if ("update".equals(action)) {
            // Handle Update Customer
            handleUpdateCustomer(request, response);
        } else if ("delete".equals(action)) {
            // Handle Delete Customer
            handleDeleteCustomer(request, response);
        } else {
            response.sendRedirect("customers.jsp?error=1");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("🚀 doGet() method is called!");
        try {
            System.out.println("Fetching all customers...");
            List<Customer> customers = customerService.getAllCustomers();
            System.out.println("Total Customers Retrieved: " + customers.size()); // Debugging
            request.setAttribute("customers", customers);
            request.getRequestDispatcher("customers.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace(); // Print error details in logs
            response.sendRedirect("customers.jsp?error=1");
        }
    }

    private void handleAddCustomer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String registrationNumber = request.getParameter("registrationNumber");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String nic = request.getParameter("nic");
        String telephone = request.getParameter("telephone");

        Customer customer = new Customer();
        customer.setRegistrationNumber(registrationNumber);
        customer.setName(name);
        customer.setAddress(address);
        customer.setNic(nic);
        customer.setTelephone(telephone);

        try {
            customerService.registerCustomer(customer);
            response.sendRedirect("customers?success=1");
        } catch (SQLException e) {
            response.sendRedirect("customers?error=1");
        }
    }

    private void handleUpdateCustomer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String registrationNumber = request.getParameter("registrationNumber");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String nic = request.getParameter("nic");
        String telephone = request.getParameter("telephone");

        Customer customer = new Customer();
        customer.setRegistrationNumber(registrationNumber);
        customer.setName(name);
        customer.setAddress(address);
        customer.setNic(nic);
        customer.setTelephone(telephone);

        try {
            customerService.updateCustomer(customer);
            response.sendRedirect("customers?success=1");
        } catch (SQLException e) {
            response.sendRedirect("customers?error=1");
        }
    }

    private void handleDeleteCustomer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String registrationNumber = request.getParameter("registrationNumber");

        try {
            customerService.deleteCustomer(registrationNumber);
            response.sendRedirect("customers?success=1");
        } catch (SQLException e) {
            response.sendRedirect("customers?error=1");
        }
    }
}
