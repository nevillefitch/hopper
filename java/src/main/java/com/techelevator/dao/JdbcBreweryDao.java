package com.techelevator.dao;

import com.techelevator.model.Brewery;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Service;

import java.io.Console;
import java.util.ArrayList;
import java.util.List;

@Service
public class JdbcBreweryDao implements BreweryDao {

    private JdbcTemplate jdbcTemplate;

    public JdbcBreweryDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }


    @Override
    public Brewery getBrewery(int breweryId) {
        Brewery brewery = new Brewery();
        String sql = "SELECT brewery_id, brewery.name, email, phone, street_address, city, state, zipcode, history, logo_img, is_active, has_food, owner_id "
                + "FROM brewery "
                + "WHERE brewery_id = ?";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, breweryId);
        if (results.next()) {
            brewery = mapRowToBrewery(results);
            return brewery;
        } else {
            throw new RuntimeException("Brewery with ID " + breweryId + " was not found.");
        }
    }

    @Override
    public List<Brewery> getBreweries() {
        List<Brewery> breweries = new ArrayList<>();
        String sql = "SELECT brewery_id, brewery.name, email, phone, street_address, city, state, zipcode, history, logo_img, is_active, has_food, owner_id FROM brewery";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql);
        while (results.next()) {
            Brewery brewery = mapRowToBrewery(results);
            breweries.add(brewery);
        }

        return breweries;
    }

    @Override
    public Brewery addBrewery(Brewery brewery) {
        Brewery newBrewery = new Brewery();
        String sql = "INSERT INTO brewery(brewery.name, owner_id) " +
                "VALUES(?, ?)";
        try {
            int newBreweryId = jdbcTemplate.queryForObject(sql, int.class, brewery.getBreweryId(), brewery.getOwnerId());
            newBrewery = getBrewery(newBreweryId);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return newBrewery;
    }

    @Override
    public boolean updateBrewery(Brewery brewery) {
        boolean isUpdated = false;
        Brewery newBrewery = getBrewery(brewery.getBreweryId());
        String sql = "UPDATE brewery " +
                "SET brewery.name = ?, email = ?, phone = ?, street_address = ?, " +
                "city = ?, state = ?, zipcode = ?, history = ?, logo_img = ?, is_active = ?, has_food = ? " +
                "WHERE brewery_id = ?";
        if (newBrewery != null) {
            jdbcTemplate.update(sql, brewery.getName(), brewery.getEmail(),
                    brewery.getPhone(), brewery.getStreetAddress(),
                    brewery.getCity(), brewery.getState(), brewery.getZip(),
                    brewery.getHistory(), brewery.getLogo(), brewery.isActive(),
                    brewery.isHasFood(), brewery.getBreweryId());
            isUpdated = true;
        }
        return isUpdated;
    }

    @Override
    public boolean deleteBrewery(int breweryId) {
        return false;
    }

    private Brewery mapRowToBrewery(SqlRowSet rowSet) {
        Brewery brewery = new Brewery();

        brewery.setBreweryId(rowSet.getInt("brewery_id"));
        brewery.setName(rowSet.getString("name"));
        brewery.setEmail(rowSet.getString("email"));
        brewery.setPhone(rowSet.getString("phone"));
        brewery.setStreetAddress(rowSet.getString("street_address"));
        brewery.setCity(rowSet.getString("city"));
        brewery.setState(rowSet.getString("state"));
        brewery.setZip(rowSet.getString("zipcode"));
        brewery.setHistory(rowSet.getString("history"));
        brewery.setLogo(rowSet.getString("logo_img"));
        brewery.setActive(rowSet.getBoolean("is_active"));
        brewery.setHasFood(rowSet.getBoolean("has_food"));
        brewery.setOwnerId(rowSet.getInt("owner_id"));

        return brewery;

    }
}
