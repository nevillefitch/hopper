package com.techelevator.controller;


import com.techelevator.dao.BeerDao;
import com.techelevator.model.Beer;
import com.techelevator.model.BeerType;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("beers")
public class BeerController {

    private BeerDao beerDao;

    public BeerController(BeerDao beerDao) {
        this.beerDao = beerDao;
    }

    @PreAuthorize("permitAll()")
    @RequestMapping(value = "/brewery/{id}", method = RequestMethod.GET)
    public List<Beer> getBeersByBrewery(@PathVariable int id) {
        return beerDao.getBeers(id);
    }

    @PreAuthorize("permitAll()")
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public Beer getBeer(@PathVariable int id) {
        return beerDao.getBeer(id);
    }

    @PreAuthorize("hasRole('ROLE_BREWER')")
    @RequestMapping(value = "/types/", method = RequestMethod.GET)
    public List<BeerType> getBeerTypes() {
        return beerDao.getBeerTypes();
    }



    @PreAuthorize("hasRole('ROLE_BREWER')")
    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(value = "/", method = RequestMethod.POST)
    public Beer addBeer(@RequestBody Beer beer) {
        return beerDao.addBeer(beer);
    }


    @PreAuthorize("hasRole('ROLE_BREWER')")
    @RequestMapping(value = "/", method = RequestMethod.PUT)
    public boolean updateBeer(@RequestBody Beer beer) {
        if (beerDao.updateBeer(beer)) {
            return true;
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Beer not found to update.");
        }
    }


}
