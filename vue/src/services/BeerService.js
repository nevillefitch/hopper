import axios from "axios";


export default {
    getBeers(breweryId){
        return axios.get(`/beers/brewery/${breweryId}`);
    }
}