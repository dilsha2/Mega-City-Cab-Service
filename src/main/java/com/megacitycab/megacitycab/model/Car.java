package com.megacitycab.megacitycab.model;

public class Car {
    private String carId;
    private String model;
    private String licensePlate;
    private double price;
    private String status;

    public Car() {
    }

    public Car(String carId, String model, String licensePlate, double price, String status) {
        this.carId = carId;
        this.model = model;
        this.licensePlate = licensePlate;
        this.price = price;
        this.status = status;
    }

    public Car(String carId) {
        this.carId = carId;
    }

    public String getCarId() {
        return carId;
    }

    public void setCarId(String carId) {
        this.carId = carId;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}