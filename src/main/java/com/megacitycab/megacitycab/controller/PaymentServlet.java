package com.megacitycab.megacitycab.controller;

import com.megacitycab.megacitycab.dao.CarDAO;
import com.megacitycab.megacitycab.dao.DriverDAO;
import com.megacitycab.megacitycab.dao.PaymentDAO;
import com.megacitycab.megacitycab.model.Payment;
import com.megacitycab.megacitycab.service.CarService;
import com.megacitycab.megacitycab.service.DriverService;
import com.megacitycab.megacitycab.service.PaymentService;
import com.megacitycab.megacitycab.util.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {
    private PaymentService paymentService;
    private CarService carService;
    private DriverService driverService;

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DBUtil.getConnection();
            paymentService = new PaymentService(new PaymentDAO(connection));
            carService = new CarService(new CarDAO(connection));
            driverService = new DriverService(new DriverDAO(connection));
        } catch (SQLException e) {
            throw new ServletException("Unable to connect to database", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("pay".equals(action)) {
            try {
                handleAddPayment(request, response);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } else {
            response.sendRedirect("bookings.jsp?error=Invalid action");
        }
    }

    private void handleAddPayment(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        // Extract payment details from the request
        String paymentId = request.getParameter("paymentId");
        String customerId = request.getParameter("customerId");
        String bookingNumber = request.getParameter("bookingNumber");
        double amount = Double.parseDouble(request.getParameter("amount"));
        String status = request.getParameter("status");

        // Create a new payment object
        Payment payment = new Payment();
        payment.setPaymentId(paymentId);
        payment.setCustomerId(customerId);
        payment.setBookingNumber(bookingNumber);
        payment.setAmount(amount);
        payment.setStatus(status);

        // Add payment to the database
        paymentService.addPayment(payment);

        // Redirect after successful payment creation
        response.sendRedirect("payments.jsp?success=1");
    }
}
