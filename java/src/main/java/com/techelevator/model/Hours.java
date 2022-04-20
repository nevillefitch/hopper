package com.techelevator.model;

import java.time.LocalTime;

public class Hours {

    private String dayName;
    private int dayId;
    private String dayAbbreviation;
    private LocalTime open;
    private LocalTime close;


    public int getDayId() {
        return dayId;
    }

    public void setDayId(int dayId) {
        this.dayId = dayId;
    }

    public String getDayName() {
        return dayName;
    }

    public void setDayName(String dayName) {
        this.dayName = dayName;
    }

    public String getDayAbbreviation() {
        return dayAbbreviation;
    }

    public void setDayAbbreviation(String dayAbbreviation) {
        this.dayAbbreviation = dayAbbreviation;
    }

    public LocalTime getOpen() {
        return open;
    }

    public void setOpen(LocalTime open) {
        this.open = open;
    }

    public LocalTime getClose() {
        return close;
    }

    public void setClose(LocalTime close) {
        this.close = close;
    }
}
