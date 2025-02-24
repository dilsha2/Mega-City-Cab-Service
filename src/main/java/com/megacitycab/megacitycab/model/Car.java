package com.megacitycab.megacitycab.model;

public class Car {
    private String carId;
    private String model;
    private String licensePlate;
    private double price;

    public Car() {
    }

    public Car(String carId, String model, String licensePlate, double price) {
        this.carId = carId;
        this.model = model;
        this.licensePlate = licensePlate;
        this.price = price;
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
}