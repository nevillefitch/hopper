package com.techelevator.dao;

import com.techelevator.model.Beer;

import java.util.List;

public interface BeerDao {
    Beer getBeer(int beerId);
    List<Beer> getBeers(int breweryId);
    Beer addBeer(Beer beer);
    Boolean updateBeer(Beer beer);

}
