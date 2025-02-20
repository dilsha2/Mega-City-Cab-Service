package com.megacitycab.megacitycab.controller;


import com.megacitycab.megacitycab.dao.DriverDAO;
import com.megacitycab.megacitycab.model.Driver;
import com.megacitycab.megacitycab.service.DriverService;
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

@WebServlet("/drivers")
public class DriverServlet extends HttpServlet {
    private DriverService driverService;

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DBUtil.getConnection();
            driverService = new DriverService(new DriverDAO(connection));
        } catch (SQLException e) {
            throw new ServletException("Unable to connect to database", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action"); // Determine the action (add, update, delete)

        if ("add".equals(action)) {
            handleAddDriver(request, response);
        } else if ("update".equals(action)) {
            handleUpdateDriver(request, response);
        } else if ("delete".equals(action)) {
            handleDeleteDriver(request, response);
        } else {
            response.sendRedirect("drivers.jsp?error=1");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Driver> drivers = driverService.getAllDrivers();
            request.setAttribute("drivers", drivers);
            request.getRequestDispatcher("drivers.jsp").forward(request, response);
        } catch (SQLException e) {
            response.sendRedirect("drivers.jsp?error=1");
        }
    }

    private void handleAddDriver(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String driverId = request.getParameter("driverId");
        String name = request.getParameter("name");
        String licenseNumber = request.getParameter("licenseNumber");

        Driver driver = new Driver();
        driver.setDriverId(driverId);
        driver.setName(name);
        driver.setLicenseNumber(licenseNumber);

        try {
            driverService.addDriver(driver);
            response.sendRedirect("drivers?success=1");
        } catch (SQLException e) {
            response.sendRedirect("drivers?error=1");
        }
    }

    private void handleUpdateDriver(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String driverId = request.getParameter("driverId");
        String name = request.getParameter("name");
        String licenseNumber = request.getParameter("licenseNumber");

        Driver driver = new Driver();
        driver.setDriverId(driverId);
        driver.setName(name);
        driver.setLicenseNumber(licenseNumber);

        try {
            driverService.updateDriver(driver);
            response.sendRedirect("drivers?success=1");
        } catch (SQLException e) {
            response.sendRedirect("drivers?error=1");
        }
    }

    private void handleDeleteDriver(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String driverId = request.getParameter("driverId");

        try {
            driverService.deleteDriver(driverId);
            response.sendRedirect("drivers?success=1");
        } catch (SQLException e) {
            response.sendRedirect("drivers?error=1");
        }
    }
}