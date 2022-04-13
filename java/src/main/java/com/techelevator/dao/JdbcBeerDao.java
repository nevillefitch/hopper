package com.techelevator.dao;

import com.techelevator.model.Beer;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class JdbcBeerDao implements BeerDao{
    private JdbcTemplate jdbcTemplate;

    public JdbcBeerDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    //TODO expand sql statement to return average rating and set it
    @Override
    public Beer getBeer(int beerId) {
        Beer beer = null;
        String sql = "SELECT beer_id, brewery_id, name, img_path, description, price, abv, is_active, type_name, b.beer_type_id " +
                "FROM beer AS b " +
                "JOIN beer_type AS t " +
                    "ON b.beer_type_id = t.beer_type_id " +
                "WHERE beer_id = ?; ";

        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, beerId);
        if (results.next()) {
            beer = mapRowToBeer(results);
            return beer;
        } else {
            throw new RuntimeException("Beer with ID " + beerId + " was not found.");
        }

    }
    //TODO expand sql statement to return average rating and set it
    @Override
    public List<Beer> getBeers(int breweryId) {
        List<Beer> beers = new ArrayList<>();
        String sql = "SELECT beer_id, brewery_id, name, img_path, description, price, abv, is_active, type_name, b.beer_type_id " +
                "FROM beer AS b " +
                "JOIN beer_type AS t " +
                    "ON b.beer_type_id = t.beer_type_id " +
                "WHERE brewery_id = ?; ";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, breweryId);
        while (results.next()) {
            Beer beer = mapRowToBeer(results);
            beers.add(beer);
        }
        return beers;
    }

    @Override
    public Beer addBeer(Beer beer) {
        Beer newBeer = null;
        String sql = "INSERT INTO beer (brewery_id, name, img_path, description, price, abv, is_active, beer_type_id ) " +
                    "VALUES(?,?,?,?,?,?,?,?) " +
                    "RETURNING beer_id;" ;
        try {
            int newBeerId = jdbcTemplate.queryForObject(sql, int.class, beer.getBreweryId(), beer.getName(), beer.getImagePath(),
                    beer.getDescription(), beer.getPrice(), beer.getAbv(), beer.isActive(), beer.getBeerTypeId());
            newBeer = getBeer(newBeerId);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return newBeer;

    }

    @Override
    public Boolean updateBeer(Beer beer) {
        String sql = "UPDATE beer " +
        "SET name = ?, img_path = ?, description = ?, price = ?, abv = ?, is_active = ?, beer_type_id = ? " +
        "WHERE beer_id = ?;";
        int count = jdbcTemplate.update(sql, beer.getName(), beer.getImagePath(), beer.getDescription(), beer.getPrice(),
                beer.getAbv(), beer.isActive(), beer.getBeerTypeId(), beer.getBeerId());
        return count == 1;
    }

    public Beer mapRowToBeer(SqlRowSet rowSet) {
        Beer beer = new Beer();
        beer.setBeerId(rowSet.getInt("beer_id"));
        beer.setName(rowSet.getString("name"));
        beer.setBreweryId(rowSet.getInt("brewery_id"));
        beer.setImagePath(rowSet.getString("img_path"));
        beer.setDescription(rowSet.getString("description"));
        beer.setPrice(rowSet.getDouble("price"));
        beer.setAbv(rowSet.getDouble("abv"));
        beer.setActive(rowSet.getBoolean("is_active"));
        beer.setBeerType(rowSet.getString("type_name"));
        beer.setBeerTypeId(rowSet.getInt("beer_type_id"));
        return beer;
    }
}
