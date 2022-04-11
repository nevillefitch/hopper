package com.techelevator.controller;

import com.techelevator.dao.BreweryDao;
import com.techelevator.model.Brewery;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@CrossOrigin
@RequestMapping ("/breweries")
public class BreweryController {
    private BreweryDao dao;

    public BreweryController(BreweryDao dao) {
        this.dao = dao;
    }

    @PreAuthorize("permitAll()")
    @RequestMapping(value="", method = RequestMethod.GET)
    public List<Brewery> getBreweries(){
        return dao.getBreweries();

    }
}
