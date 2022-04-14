import axios from "axios";
const http = axios.create({
    baseURL: "http://localhost:3000/beers"
});

export default {
    getBeers(breweryId){
        return http.get(`/brewery/${breweryId}`);
    }
}