package com.megacitycab.megacitycab.model;


public class Booking {
    private String bookingNumber;
    private Customer customer;
    private String destination;
    private double distance;
    private double fare;
    private Car car;
    private Driver driver;

    public Booking() {
    }

    public Booking(String bookingNumber, Customer customer, String destination, double distance, double fare, Car car, Driver driver) {
        this.setBookingNumber(bookingNumber);
        this.setCustomer(customer);
        this.setDestination(destination);
        this.setDistance(distance);
        this.setFare(fare);
        this.setCar(car);
        this.setDriver(driver);
    }

    public String getBookingNumber() {
        return bookingNumber;
    }

    public void setBookingNumber(String bookingNumber) {
        this.bookingNumber = bookingNumber;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
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

    public Car getCar() {
        return car;
    }

    public void setCar(Car car) {
        this.car = car;
    }

    public Driver getDriver() {
        return driver;
    }

    public void setDriver(Driver driver) {
        this.driver = driver;
    }
}