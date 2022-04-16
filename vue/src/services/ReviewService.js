import axios from "axios";

export default {
    getReviewList(id){
        return axios.get(`/reviews/beers/${id}`);
    },
    createReview(review){
        return axios.post(`/reviews/`,review)
    }
}