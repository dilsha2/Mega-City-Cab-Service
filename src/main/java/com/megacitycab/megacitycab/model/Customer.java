/**
 * Created By Dilsha Prasanna
 * Date : 2/16/2025
 * Time : 9:01 PM
 * Project Name : Mega City Cab
 */

package com.megacitycab.megacitycab.model;

public class Customer {

    private String registrationNumber;
    private String name;
    private String address;
    private String nic;
    private String telephone;

    public Customer() {
    }

    public Customer(String registrationNumber, String name, String address, String nic, String telephone) {
        this.registrationNumber = registrationNumber;
        this.name = name;
        this.address = address;
        this.nic = nic;
        this.telephone = telephone;
    }

    public Customer(String registrationNumber) {
        this.registrationNumber = registrationNumber;
    }

    public String getRegistrationNumber() {
        return registrationNumber;
    }

    public void setRegistrationNumber(String registrationNumber) {
        this.registrationNumber = registrationNumber;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }
}
