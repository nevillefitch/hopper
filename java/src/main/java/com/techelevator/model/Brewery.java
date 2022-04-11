package com.techelevator.model;

public class Brewery {
    private int breweryId;
    private String name;
    private String email;
    private String phone;
    private String streetAddress;
    private String city;
    private String state;
    private String zip;
    private String history;
    private String logo;
    private boolean isActive;
    private boolean hasFood;
    private int ownerId;

    public int getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(int ownerId) {
        this.ownerId = ownerId;
    }

    public Brewery() {
    }

    public Brewery(int breweryId, String name, int ownerId) {
        this.breweryId = breweryId;
        this.name = name;
        this.ownerId = ownerId;
    }

    public int getBreweryId() {
        return breweryId;
    }

    public void setBreweryId(int breweryId) {
        this.breweryId = breweryId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getStreetAddress() {
        return streetAddress;
    }

    public void setStreetAddress(String streetAddress) {
        this.streetAddress = streetAddress;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getZip() {
        return zip;
    }

    public void setZip(String zip) {
        this.zip = zip;
    }

    public String getHistory() {
        return history;
    }

    public void setHistory(String history) {
        this.history = history;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public boolean isHasFood() {
        return hasFood;
    }

    public void setHasFood(boolean hasFood) {
        this.hasFood = hasFood;
    }

    @Override
    public String toString() {
        return "Brewery{" +
                "breweryId=" + breweryId +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", streetAddress='" + streetAddress + '\'' +
                ", city='" + city + '\'' +
                ", state='" + state + '\'' +
                ", zip='" + zip + '\'' +
                ", history='" + history + '\'' +
                ", logo='" + logo + '\'' +
                ", isActive=" + isActive +
                ", hasFood=" + hasFood +
                '}';
    }
}


