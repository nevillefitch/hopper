package com.techelevator.model;

import java.sql.Time;
import java.time.LocalTime;

public class Hours {

    private String dayName;
    private int dayId;
    private String dayAbbreviation;
    private String open;
    private String close;


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

    public String getOpen() {
        return open;
    }

    public void setOpen(String open) {
        this.open = open;
    }

    public String getClose() {
        return close;
    }

    public void setClose(String close) {
        this.close = close;
    }
}
