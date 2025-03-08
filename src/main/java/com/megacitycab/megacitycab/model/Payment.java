package com.megacitycab.megacitycab.model;

import java.time.LocalDateTime;
import java.util.Date;

public class Payment {

    private String paymentId;
    private String customerId;
    private String bookingNumber;
    private String carId;
    private double amount;
    private String status;


    public Payment(){}
    // Constructor
    public Payment(String paymentId, String customerId, String bookingNumber, String carId, double amount, String status) {
        this.paymentId = paymentId;
        this.customerId = customerId;
        this.bookingNumber = bookingNumber;
        this.carId = carId;
        this.amount = amount;
        this.status = status;
    }

    // Getters and Setters
    public String getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(String paymentId) {
        this.paymentId = paymentId;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public String getBookingNumber() {
        return bookingNumber;
    }

    public void setBookingNumber(String bookingNumber) {
        this.bookingNumber = bookingNumber;
    }

    public String getCarId() {
        return carId;
    }

    public void setCarId(String carId) {
        this.carId = carId;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
