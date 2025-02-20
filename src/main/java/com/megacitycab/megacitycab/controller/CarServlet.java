package com.megacitycab.megacitycab.controller;


import com.megacitycab.megacitycab.dao.CarDAO;
import com.megacitycab.megacitycab.model.Car;
import com.megacitycab.megacitycab.service.CarService;
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


@WebServlet("/cars")
public class CarServlet extends HttpServlet {
    private CarService carService;

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DBUtil.getConnection();
            carService = new CarService(new CarDAO(connection));
        } catch (SQLException e) {
            throw new ServletException("Unable to connect to database", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action"); // Determine the action (add, update, delete)

        if ("add".equals(action)) {
            handleAddCar(request, response);
        } else if ("update".equals(action)) {
            handleUpdateCar(request, response);
        } else if ("delete".equals(action)) {
            handleDeleteCar(request, response);
        } else {
            response.sendRedirect("cars.jsp?error=1");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Car> cars = carService.getAllCars();
            request.setAttribute("cars", cars);
            request.getRequestDispatcher("cars.jsp").forward(request, response);
        } catch (SQLException e) {
            response.sendRedirect("cars.jsp?error=1");
        }
    }

    private void handleAddCar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String carId = request.getParameter("carId");
        String model = request.getParameter("model");
        String licensePlate = request.getParameter("licensePlate");

        Car car = new Car();
        car.setCarId(carId);
        car.setModel(model);
        car.setLicensePlate(licensePlate);

        try {
            carService.addCar(car);
            response.sendRedirect("cars?success=1");
        } catch (SQLException e) {
            response.sendRedirect("cars?error=1");
        }
    }

    private void handleUpdateCar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String carId = request.getParameter("carId");
        String model = request.getParameter("model");
        String licensePlate = request.getParameter("licensePlate");

        Car car = new Car();
        car.setCarId(carId);
        car.setModel(model);
        car.setLicensePlate(licensePlate);

        try {
            carService.updateCar(car);
            response.sendRedirect("cars?success=1");
        } catch (SQLException e) {
            response.sendRedirect("cars?error=1");
        }
    }

    private void handleDeleteCar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String carId = request.getParameter("carId");

        try {
            carService.deleteCar(carId);
            response.sendRedirect("cars?success=1");
        } catch (SQLException e) {
            response.sendRedirect("cars?error=1");
        }
    }
}