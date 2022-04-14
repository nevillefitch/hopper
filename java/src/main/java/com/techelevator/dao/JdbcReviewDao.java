package com.techelevator.dao;

import com.techelevator.model.Brewery;
import com.techelevator.model.Review;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class JdbcReviewDao implements ReviewDao {

    private JdbcTemplate jdbcTemplate;

    public JdbcReviewDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }


    /**
     * Get review by Id
     * @param id
     * @return requested Review
     */
    @Override
    public Review getReview(int id) {

        Review review = new Review();

        String sql = "SELECT r.review_id, beer_id, review_message, score, u.user_id,username " +
                "FROM beer_review AS r " +
                "JOIN users AS u " +
                "ON r.user_id = u.user_id " +
                "WHERE review_id = ?;";

        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, id);
        if (results.next()) {
            review = mapRowToReview(results);
            return review;
        } else {
            throw new RuntimeException("Review with ID " + id + " was not found.");
        }
    }

    /**
     * Get reviews for selected beer by beer ID
     * @param beerId
     * @return  Beers
     */
    @Override
    public List<Review> getReviews(int beerId) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.review_id, beer_id, review_message, score, u.user_id, username " +
                "FROM beer_review AS r " +
                "JOIN users AS u " +
                "ON r.user_id = u.user_id;";

        SqlRowSet results = jdbcTemplate.queryForRowSet(sql);
        while (results.next()) {
            Review review = mapRowToReview(results);
            reviews.add(review);
        }
        return reviews;

    }

    /**
     * Add review to beer
     * @param review
     * @return  added review
     */
    @Override
    public Review addReview(Review review) {

        Review newReview = new Review();

        String sql = "INSERT INTO beer_review (beer_id, review_message, score, user_id) " +
                "VALUES (?, ?, ?, ?) " +
                "RETURNING review_id; ";

        try {
            int newReviewId = jdbcTemplate.queryForObject(sql, int.class, review.getBeerId(), review.getMessage(), review.getScore(), review.getUserId());
            newReview = getReview(newReviewId);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }


        return newReview;
    }


    private Review mapRowToReview(SqlRowSet rowSet) {
        Review review = new Review();

        review.setReviewId(rowSet.getInt("review_id"));
        review.setBeerId(rowSet.getInt("beer_id"));
        review.setMessage(rowSet.getString("review_message"));
        review.setScore(rowSet.getInt("score"));
        review.setUserId(rowSet.getInt("user_id"));
        review.setUserName(rowSet.getString("username"));

        return  review;
    }


}
