package com.techelevator.controller;


import com.techelevator.dao.ReviewDao;
import com.techelevator.model.Review;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("reviews")
public class ReviewController {

    private ReviewDao reviewDao;

    public ReviewController(ReviewDao reviewDao) {
        this.reviewDao = reviewDao;
    }

    @PreAuthorize("permitAll()")
    @RequestMapping(value = "/beers/{id}", method = RequestMethod.GET)
    public List<Review> getReviewsByBeerId(@PathVariable int id) {
        return reviewDao.getReviews(id);
    }

    @PreAuthorize("permitAll()")
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public Review getReview(@PathVariable int id) {
        return reviewDao.getReview(id);
    }


    @PreAuthorize("hasRole('ROLE_USER')")
    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(value = "/", method = RequestMethod.POST)
    public Review addReview(@RequestBody Review review) {
        return reviewDao.addReview(review);
    }


}
