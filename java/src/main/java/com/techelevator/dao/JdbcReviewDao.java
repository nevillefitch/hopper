package com.techelevator.dao;

import com.techelevator.model.Review;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class JdbcReviewDao implements ReviewDao{

    private JdbcTemplate jdbcTemplate;

    public JdbcReviewDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }


    @Override
    public Review getReview(int id) {
        return null;
    }

    @Override
    public List<Review> getReviews(int beerId) {
        return null;
    }

    @Override
    public Review addBeer(Review review) {
        return null;
    }
}
