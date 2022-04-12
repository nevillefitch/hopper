package com.techelevator.dao;

import com.techelevator.model.Brewery;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Service;

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
        return null;
    }

    @Override
    public List<Brewery> getBreweries() {
        List<Brewery> breweries = new ArrayList<>();
        String sql = "SELECT brewery_id, brewery.name, email, phone, street_address, city, state," +
                " zipcode, history, logo_img, is_active, has_food, owner_id FROM brewery";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql);
        while (results.next()) {
            Brewery brewery = mapRowToBrewery(results);
            breweries.add(brewery);
        }
        return breweries;
    }

    @Override
    /**
     *
     */
    public Brewery addBrewery(Brewery brewery) {
        return null;
    }

    @Override
    public boolean updateBrewery(Brewery brewery) {
        return false;
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
