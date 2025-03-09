package com.megacitycab.megacitycab.controller;


import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;
import com.megacitycab.megacitycab.dao.*;
import com.megacitycab.megacitycab.enums.Status;
import com.megacitycab.megacitycab.model.*;
import com.megacitycab.megacitycab.service.*;
import com.megacitycab.megacitycab.util.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/bookings")
public class BookingServlet extends HttpServlet {
    private BookingService bookingService;
    private CarService carService;
    private CustomerService customerService;
    private DriverService driverService;
    private PaymentService paymentService;

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DBUtil.getConnection();
            bookingService = new BookingService(new BookingDAO(connection));
            carService = new CarService(new CarDAO(connection));
            customerService = new CustomerService(new CustomerDAO(connection));
            driverService = new DriverService(new DriverDAO(connection));
            paymentService = new PaymentService(new PaymentDAO(connection));

        } catch (SQLException e) {
            throw new ServletException("Unable to connect to database", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

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
        } else if ("pay".equals(action)) {  // New action for processing payments
            try {
                handlePayment(request, response);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } else {
            response.sendRedirect("bookings.jsp?error=1");
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookingNumber = request.getParameter("bookingNumber");

        if (bookingNumber == null || bookingNumber.isEmpty()) {
            try {
                // Fetch all bookings
                List<Booking> bookings = bookingService.getAllBookings();
                request.setAttribute("bookings", bookings);

                // Fetch available cars
                List<Car> availableCars = carService.getAllCarsWhereStatus(Status.AVAILABLE.name());
                request.setAttribute("availableCars", availableCars);

                // Fetch registered customers
                request.setAttribute("registeredCustomers", customerService.getAllCustomers());

                // Fetch available drivers
                List<Driver> availableDrivers = driverService.getAllDriversWhereStatus();
                request.setAttribute("availableDrivers", availableDrivers);

                // Forward to the JSP page
                request.getRequestDispatcher("bookings.jsp").forward(request, response);
            } catch (SQLException e) {
                response.sendRedirect("bookings.jsp?error=1");
            }
            return;
        }

        try {
            generatePdf(response, bookingNumber);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("bookings.jsp?error=Error generating receipt");
        }
    }

    private void handleAddBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String bookingNumber = request.getParameter("bookingNumber");
        String customerRegNum = request.getParameter("customerRegistrationNumber");
        String destination = request.getParameter("destination");
        double distance = Double.parseDouble(request.getParameter("distance"));
        String carId = request.getParameter("carId");
        String driverId = request.getParameter("driverId");

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

        System.out.println("Fetching Car with ID: " + driverId);
        Driver driver = driverService.getDriverById(driverId);
        if (driver == null) {
            System.out.println("driver not found: " + carId);
            response.sendRedirect("bookings.jsp?error=driver not found");
            return;
        }

        double fare = distance * car.getPrice();
        Booking booking = new Booking();
        booking.setBookingNumber(bookingNumber);
        booking.setCustomer(customer);
        booking.setDestination(destination);
        booking.setDistance(distance);
        booking.setFare(fare);
        booking.setCar(car);
        booking.setDriver(driver);

        try {
            bookingService.addBooking(booking);
            carService.updateCarStatus(carId, Status.BOOKED.name());
            driverService.updateDriverStatus(driverId, Status.BOOKED.name());

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

    private void handlePayment(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String bookingNumber = request.getParameter("bookingNumber");
        String customerRegNum = request.getParameter("customerRegistrationNumber");
        String carId = request.getParameter("carId");
        double amount = Double.parseDouble(request.getParameter("amount"));
        String driverId = request.getParameter("driverId");

        // Fetch the customer and validate the booking
        Customer customer = customerService.getCustomerByRegistrationNumber(customerRegNum);
        if (customer == null) {
            response.sendRedirect("bookings.jsp?error=Customer not found");
            return;
        }

        // Process the payment
        Payment payment = new Payment();
        payment.setBookingNumber(bookingNumber);
        payment.setCustomerId(customer.getRegistrationNumber());
        payment.setCarId(carId);
        payment.setAmount(amount);
        payment.setStatus(Status.PAID.name());

        // Save payment
        paymentService.addPayment(payment);

        // Release the car and driver, making them available
        carService.updateCarStatus(carId, Status.AVAILABLE.name());
        driverService.updateDriverStatus(driverId, Status.AVAILABLE.name());

        // Redirect to bookings page after payment
        response.sendRedirect("bookings?success=Payment successful");
    }

    private void generatePdf(HttpServletResponse response, String bookingNumber) throws SQLException, IOException {

        Booking booking = bookingService.getBookingByNumber(bookingNumber);

        if (booking == null) {
            response.sendRedirect("bookings.jsp?error=Booking not found");
            return;
        }

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Booking_Receipt_" + bookingNumber + ".pdf");

        Customer customerByRegistrationNumber = customerService.getCustomerByRegistrationNumber(booking.getCustomer().getRegistrationNumber());

        String customerName = customerByRegistrationNumber.getName();

        Driver driverById = driverService.getDriverById(booking.getDriver().getDriverId());

        String driverName = driverById.getName();

        try (OutputStream out = response.getOutputStream();
             PdfWriter writer = new PdfWriter(out);
             PdfDocument pdfDoc = new PdfDocument(writer);
             Document document = new Document(pdfDoc)) {

            document.add(new Paragraph("Mega City Cab - Booking Receipt").setBold().setFontSize(18));
            document.add(new Paragraph("------------------------------------------------------"));
            document.add(new Paragraph("Booking Number: " + booking.getBookingNumber()));
            document.add(new Paragraph("Customer: " + customerName));
            document.add(new Paragraph("Destination: " + booking.getDestination()));
            document.add(new Paragraph("Distance: " + booking.getDistance() + " km"));
            document.add(new Paragraph("Car: " + booking.getCar().getCarId()));
            document.add(new Paragraph("Driver: " + driverName));
            document.add(new Paragraph("Fare: LKR " + booking.getFare()));
            document.add(new Paragraph("------------------------------------------------------"));
            document.add(new Paragraph("Thank you for choosing Mega City Cab!"));

            document.close();
        }
    }
}
