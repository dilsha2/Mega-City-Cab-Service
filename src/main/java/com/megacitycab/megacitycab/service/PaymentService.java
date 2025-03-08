package com.megacitycab.megacitycab.service;

import com.megacitycab.megacitycab.dao.PaymentDAO;
import com.megacitycab.megacitycab.model.Payment;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class PaymentService {

    private PaymentDAO paymentDAO;

    public PaymentService(PaymentDAO paymentDAO) {
        this.paymentDAO = paymentDAO;
    }

    // Add a new payment
    public void addPayment(Payment payment) throws SQLException {
        paymentDAO.addPayment(payment);
    }

    // Get a payment by its ID
    public Payment getPaymentById(String paymentId) throws SQLException {
        return paymentDAO.getPaymentById(paymentId);
    }

    // Get all payments
    public List<Payment> getAllPayments() throws SQLException {
        return paymentDAO.getAllPayments();
    }

    // Update payment status
    public void updatePaymentStatus(String paymentId, String status) throws SQLException {
        paymentDAO.updatePaymentStatus(paymentId, status);
    }

    // Delete a payment
    public void deletePayment(String paymentId) throws SQLException {
        paymentDAO.deletePayment(paymentId);
    }
}
