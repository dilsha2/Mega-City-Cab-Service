package com.megacitycab.megacitycab.controller;


import com.megacitycab.megacitycab.dao.BookingDAO;
import com.megacitycab.megacitycab.dao.CarDAO;
import com.megacitycab.megacitycab.dao.CustomerDAO;
import com.megacitycab.megacitycab.model.Booking;
import com.megacitycab.megacitycab.model.Car;
import com.megacitycab.megacitycab.model.Customer;
import com.megacitycab.megacitycab.service.BookingService;
import com.megacitycab.megacitycab.service.CarService;
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

@WebServlet("/bookings")
public class BookingServlet extends HttpServlet {
    private BookingService bookingService;
    private CarService carService;

    private CustomerService customerService;

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DBUtil.getConnection();
            bookingService = new BookingService(new BookingDAO(connection));
            carService = new CarService(new CarDAO(connection));
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
            try {
                handleAddBooking(request, response);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } else if ("update".equals(action)) {
            handleUpdateBooking(request, response);
        } else if ("delete".equals(action)) {
            handleDeleteBooking(request, response);
        } else {
            response.sendRedirect("bookings.jsp?error=1");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Fetch bookings
            List<Booking> bookings = bookingService.getAllBookings();
            request.setAttribute("bookings", bookings);

            // Fetch available cars
            List<Car> availableCars = carService.getAllCars();  // Fetch available cars from CarService
            request.setAttribute("availableCars", availableCars);

            request.setAttribute("registeredCustomers", customerService.getAllCustomers());

            // Forward to the JSP page
            request.getRequestDispatcher("bookings.jsp").forward(request, response);
        } catch (SQLException e) {
            response.sendRedirect("bookings.jsp?error=1");
        }
    }

    private void handleAddBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String bookingNumber = request.getParameter("bookingNumber");
        String customerRegNum = request.getParameter("customerRegistrationNumber");
        String destination = request.getParameter("destination");
        double distance = Double.parseDouble(request.getParameter("distance"));
        String carId = request.getParameter("carId");  // Only one car allowed

        System.out.println("Fetching customer with registration number: " + customerRegNum);
        Customer customer = customerService.getCustomerByRegistrationNumber(customerRegNum);

        if (customer == null) {
            System.out.println("Customer not found: " + customerRegNum);
            response.sendRedirect("bookings.jsp?error=Customer not found");
            return;
        }

        System.out.println("Fetching Car with ID: " + carId);
        Car car = carService.getCarById(carId);
        if (car == null) {
            System.out.println("Car not found: " + carId);
            response.sendRedirect("bookings.jsp?error=Car not found");
            return;
        }

        double fare = distance * 2;
        Booking booking = new Booking();
        booking.setBookingNumber(bookingNumber);
        booking.setCustomer(customer);
        booking.setDestination(destination);
        booking.setDistance(distance);
        booking.setFare(fare);
        booking.setCar(car);

        try {
            bookingService.addBooking(booking);
            response.sendRedirect("bookings");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("bookings.jsp?error=1");
        }
    }

    private void handleUpdateBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookingNumber = request.getParameter("bookingNumber");
        String customerName = request.getParameter("customerName");
        String destination = request.getParameter("destination");
        double distance = Double.parseDouble(request.getParameter("distance"));

        double fare = distance * 2;

        Booking booking = new Booking();
        booking.setBookingNumber(bookingNumber);
        booking.setCustomer(new Customer(customerName));
        booking.setDestination(destination);
        booking.setDistance(distance);
        booking.setFare(fare);

        try {
            bookingService.updateBooking(booking);
            response.sendRedirect("bookings?success=1");
        } catch (SQLException e) {
            response.sendRedirect("bookings?error=1");
        }
    }

    private void handleDeleteBooking(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String bookingNumber = request.getParameter("bookingNumber");

        try {
            bookingService.deleteBooking(bookingNumber);
            response.sendRedirect("bookings?success=1");
        } catch (SQLException e) {
            response.sendRedirect("bookings?error=1");
        }
    }
}
