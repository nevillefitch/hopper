package com.techelevator.dao;

import com.techelevator.model.Brewery;
import com.techelevator.model.Hours;
import com.techelevator.model.Socials;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Service;

import java.io.Console;
import java.sql.Time;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class JdbcBreweryDao implements BreweryDao {

    private JdbcTemplate jdbcTemplate;

    public JdbcBreweryDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // JbdcTemplate.update returns the number of rows affected. The count variable is used to hold the number of rows.
    // A few methods here use this variable to return a boolean if the amount of rows affected is the correct number for a successful method call (1)


    /**
     * Gets a single brewery by brewery id
     *
     * @param breweryId
     * @return Brewery
     */
    @Override
    public Brewery getBrewery(int breweryId) {
        Brewery brewery = new Brewery();
        String sql = "SELECT br.brewery_id, br.name, email, phone, street_address, city, state, zipcode, " +
                "history, logo_img, br.is_active, has_food, owner_id, website_url, AVG(price) AS avg_price " +
                "FROM brewery AS br " +
                "LEFT JOIN beer " +
                "ON br.brewery_id = beer.beer_id " +
                "WHERE br.brewery_id = ? " +
                "GROUP BY br.brewery_id; ";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, breweryId);
        if (results.next()) {
            brewery = mapRowToBrewery(results);
            return brewery;
        } else {
            throw new RuntimeException("Brewery with ID " + breweryId + " was not found.");
        }
    }


    /**
     * gets all breweries
     *
     * @return array list of breweries
     */
    @Override
    public List<Brewery> getBreweries() {
        List<Brewery> breweries = new ArrayList<>();
        String sql = "SELECT br.brewery_id, br.name, email, phone, street_address, city, state, zipcode, " +
                "history, logo_img, br.is_active, has_food, owner_id, website_url, AVG(price) AS avg_price " +
                "FROM brewery AS br " +
                "LEFT JOIN beer " +
                "ON br.brewery_id = beer.beer_id " +
                "GROUP BY br.brewery_id; ";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql);
        while (results.next()) {
            Brewery brewery = mapRowToBrewery(results);
            breweries.add(brewery);
        }
        return breweries;
    }

    /**
     * used by an admin to create a brewery with the base template information of a brewery name and the associated brewer (owner_id)
     *
     * @param brewery
     * @return Brewery
     */
    @Override
    public Brewery addBrewery(Brewery brewery) {
        Brewery newBrewery = new Brewery();
        String sql = "INSERT INTO brewery(name, owner_id, is_active) " +
                "VALUES(?, ?,'false') " +
                "RETURNING brewery_id; ";
        try {
            int newBreweryId = jdbcTemplate.queryForObject(sql, int.class, brewery.getName(), brewery.getOwnerId());
            boolean addHoursResult = addHours(newBreweryId);
            boolean addSocialsResult = addSocials(newBreweryId);
            if (!addHoursResult || !addSocials(newBreweryId)) {
                throw new Exception();
            }
            newBrewery = getBrewery(newBreweryId);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return newBrewery;
    }

    public boolean addSocials(int id) {
        String sql =    "INSERT INTO social (brewery_id, social_id, url) VALUES (?,1,''); " +
                        "INSERT INTO social (brewery_id, social_id, url) VALUES (?,2,''); " +
                        "INSERT INTO social (brewery_id, social_id, url) VALUES (?,3,''); ";
        int count = jdbcTemplate.update(sql,id,id,id);
        return count == 3;
    }

    public boolean addHours(int id) {


        String sql = "INSERT INTO hours (brewery_id, day_id, open, close) " +
                "VALUES (?, " +
                "(SELECT day_id FROM day WHERE abbreviation = 'Mon'), " +
                "'00:00:00', '00:00:00'); " +

                "INSERT INTO hours (brewery_id, day_id, open, close) " +
                "VALUES (?, " +
                "(SELECT day_id FROM day WHERE abbreviation = 'Tue'), " +
                "'00:00:00', '00:00:00'); " +

                "INSERT INTO hours (brewery_id, day_id, open, close) " +
                "VALUES (?, " +
                "(SELECT day_id FROM day WHERE abbreviation = 'Wed'), " +
                "'00:00:00', '00:00:00'); " +

                "INSERT INTO hours (brewery_id, day_id, open, close) " +
                "VALUES (?, " +
                "(SELECT day_id FROM day WHERE abbreviation = 'Thu'), " +
                "'00:00:00', '00:00:00'); " +

                "INSERT INTO hours (brewery_id, day_id, open, close) " +
                "VALUES (?, " +
                "(SELECT day_id FROM day WHERE abbreviation = 'Fri'), " +
                "'00:00:00', '00:00:00'); " +

                "INSERT INTO hours (brewery_id, day_id, open, close) " +
                "VALUES (?, " +
                "(SELECT day_id FROM day WHERE abbreviation = 'Sat'), " +
                "'00:00:00', '00:00:00'); " +

                "INSERT INTO hours (brewery_id, day_id, open, close) " +
                "VALUES (?, " +
                "(SELECT day_id FROM day WHERE abbreviation = 'Sun'), " +
                "'00:00:00', '00:00:00'); ";

            int count = jdbcTemplate.update(sql, id, id, id, id, id, id, id);
            return count == 7;

    }
    /**
     * used by a brewer to add/update the information associated with their brewery (email, phone, address, etc)
     *
     * @param brewery
     * @return boolean
     */


    //todo call update hours and update socials methods
    @Override
    public boolean updateBrewery(Brewery brewery) throws ParseException {
        boolean success = false;
        String sql = "UPDATE brewery " +
                "SET name = ?, email = ?, phone = ?, street_address = ?, " +
                "city = ?, state = ?, zipcode = ?, history = ?, logo_img = ?, is_active = ?, has_food = ?, website_url = ? " +
                "WHERE brewery_id = ?";
        int breweryCount = jdbcTemplate.update(sql, brewery.getName(), brewery.getEmail(),
                brewery.getPhone(), brewery.getStreetAddress(),
                brewery.getCity(), brewery.getState(), brewery.getZip(),
                brewery.getHistory(), brewery.getLogo(), brewery.isActive(),
                brewery.isHasFood(), brewery.getWebsite(), brewery.getBreweryId());

        boolean updatedSocials = updateSocials(brewery);
        boolean updatedHours = updateHours(brewery);

        if(breweryCount == 1 && updatedSocials && updatedHours) {
            success = true;
        }
        return success;
    }


    public boolean updateSocials(Brewery brewery) {
        boolean success = false;
        int updateCount = 0;

        List<Socials> socials = brewery.getSocials();
        int socialsSize = socials.size();


        String sql = "UPDATE social SET url = ? WHERE brewery_id = ? AND social_id = ?;";

        if (socialsSize > 0) {
            for (Socials social : socials) {
                int count = 0;
                String url = social.getUrl();
                int breweryId = social.getBreweryId();
                int socialId = social.getSocialId();
                try {
                    count = jdbcTemplate.update(sql, url, breweryId, socialId);
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
                updateCount = updateCount + count;
            }
        } else {
            return true;
        }

        if (socialsSize == updateCount) {
            success = true;
        }

        return success;
    }


    public boolean updateHours(Brewery brewery) throws ParseException {
        int breweryId    = brewery.getBreweryId();
        boolean success = false;
        int updateCount = 0;

        List<Hours> hours = brewery.getHours();
        int hoursSize = hours.size();


        String sql = "UPDATE hours SET open = ?, close = ? WHERE brewery_id = ? AND day_id = ?;";

        if (hoursSize > 0) {
            for (Hours day : hours) {
                int count = 0;
                String open  = day.getOpen();
                String close = day.getClose();

                DateFormat dateFormat = new SimpleDateFormat("hh:mm:ss");
                Date openTime = dateFormat.parse(open+":00");
                Date closeTime = dateFormat.parse(close+":00");



                int dayId = day.getDayId();
                try {
                    count = jdbcTemplate.update(sql, openTime, closeTime, breweryId, day.getDayId());
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }


                updateCount = updateCount + count;
            }
        } else {
            return true;
        }

        if (hoursSize == updateCount) {
            success = true;
        }

        return success;
    }






    public List<Socials> getSocials(int breweryId) {
        List<Socials> socials = new ArrayList<>();
        String sql = "SELECT brewery_id, s.social_id, social_name,url " +
                "FROM social s " +
                "LEFT JOIN social_name sn ON sn.social_id = s.social_id " +
                "WHERE brewery_id = ?;";

        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, breweryId);
        while (results.next()) {
            Socials s = mapRowToSocials(results);
            socials.add(s);
        }
        return socials;
    }

    public List<Hours> getHours(int breweryId) {
        List<Hours> hours = new ArrayList<>();
        String sql = "SELECT name, hours.day_id,abbreviation, open, close " +
                "FROM hours " +
                "LEFT JOIN day " +
                "ON day.day_id = hours.day_id " +
                "WHERE brewery_id = ?;";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, breweryId);
        while (results.next()) {
                    Hours h = mapRowToHours(results);
                    hours.add(h);
        }
        return hours;
    }

    public List<String> getImages(int breweryId) {
        List<String> images = new ArrayList<>();
        String sql = "SELECT image_path " +
                "FROM image " +
                "WHERE brewery_id = ?;";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, breweryId);
        while (results.next()) {
                String s = results.getString("image_path");
                images.add(s);
        }
        return images;
    }

    private Socials mapRowToSocials(SqlRowSet rowSet) {
        Socials socials = new Socials();
        socials.setBreweryId(rowSet.getInt("brewery_id"));
        socials.setSocialId(rowSet.getInt("social_id"));
        socials.setSocialName(rowSet.getString("social_name"));
        socials.setUrl(rowSet.getString("url"));
        return socials;
    }


    private Hours mapRowToHours(SqlRowSet rowSet) {
        Hours hours = new Hours();
        hours.setDayName(rowSet.getString("name"));
        hours.setDayId(rowSet.getInt("day_id"));
        hours.setDayAbbreviation(rowSet.getString("abbreviation"));
        hours.setOpen(rowSet.getString("open"));
        hours.setClose(rowSet.getString("close"));
        return hours;
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
        brewery.setAvgPrice(rowSet.getDouble("avg_price"));
        brewery.setWebsite(rowSet.getString("website_url"));
        brewery.setHours(getHours(brewery.getBreweryId()));
        brewery.setImages(getImages(brewery.getBreweryId()));
        brewery.setSocials(getSocials(brewery.getBreweryId()));

        return brewery;

    }
}
