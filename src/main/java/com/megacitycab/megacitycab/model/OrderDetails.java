package com.megacitycab.megacitycab.model;

public class OrderDetails {
    private String orderId;
    private Booking booking;
    private Car car;
    private Customer customer;

    public OrderDetails() {
    }

    public OrderDetails(String orderId, Booking booking, Car car, Customer customer) {
        this.orderId = orderId;
        this.booking = booking;
        this.car = car;
        this.customer = customer;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public Booking getBooking() {
        return booking;
    }

    public void setBooking(Booking booking) {
        this.booking = booking;
    }

    public Car getCar() {
        return car;
    }

    public void setCar(Car car) {
        this.car = car;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    // Getters and Setters
}