package com.techelevator.controller;

import com.techelevator.dao.BreweryDao;
import com.techelevator.model.Brewery;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

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


    @PreAuthorize("permitAll()")
    @RequestMapping(value="/{id}", method = RequestMethod.GET)
    public Brewery getBrewery(@PathVariable int id) {
        return dao.getBrewery(id);
    }

    //TODO permission for admin
    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(value="", method = RequestMethod.POST)
    public Brewery addBrewery(@RequestBody Brewery brewery) {
        return dao.addBrewery(brewery);
    }

    //TODO  add permission for brewer only
    @RequestMapping(value = "", method = RequestMethod.PUT)
    public boolean updateBrewery(@RequestBody Brewery brewery) {
        if (dao.updateBrewery(brewery)) {
            return true;
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Brewery not found to update.");
        }
    }

    //TODO permission for admin
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @RequestMapping(value="/{id}", method = RequestMethod.DELETE)
    public boolean deleteBrewery(@PathVariable int id) {
        if (dao.deleteBrewery(id)) {
            return true;
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Brewery does not exist.");
        }
    }



}
