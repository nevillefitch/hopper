import axios from "axios";


export default {
    getBeers(breweryId){
        return axios.get(`/beers/brewery/${breweryId}`);
    },
    updateBeer(beer){
        return axios.put(`/beers/`, beer);
    }
}