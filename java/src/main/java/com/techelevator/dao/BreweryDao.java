package com.techelevator.dao;
import com.techelevator.model.Brewery;

import java.text.ParseException;
import java.util.List;


public interface BreweryDao {
    Brewery getBrewery(int breweryId);
    List<Brewery> getBreweries();
    Brewery addBrewery(Brewery brewery);
    boolean updateBrewery(Brewery brewery) throws ParseException;

}
