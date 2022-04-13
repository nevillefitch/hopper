package com.techelevator.dao;

import com.techelevator.model.Review;

import java.util.List;

public interface ReviewDao {
    Review getReview(int id);
    List<Review> getReviews(int beerId);
    Review addBeer(Review review);
}
