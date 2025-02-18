package com.megacitycab.megacitycab.model;

public class Booking {
    private String bookingNumber;
    private String customerName;
    private String destination;
    private double distance;
    private double fare;

    public Booking() {
    }

    public Booking(String bookingNumber, String customerName, String destination, double distance, double fare) {
        this.bookingNumber = bookingNumber;
        this.customerName = customerName;
        this.destination = destination;
        this.distance = distance;
        this.fare = fare;
    }

    public String getBookingNumber() {
        return bookingNumber;
    }

    public void setBookingNumber(String bookingNumber) {
        this.bookingNumber = bookingNumber;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public double getDistance() {
        return distance;
    }

    public void setDistance(double distance) {
        this.distance = distance;
    }

    public double getFare() {
        return fare;
    }

    public void setFare(double fare) {
        this.fare = fare;
    }
}