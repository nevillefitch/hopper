import axios from "axios";

export default {
    getReviewList(id){
        return axios.get(`/reviews/beers/${id}`);
    }
}