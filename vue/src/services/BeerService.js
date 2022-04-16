import axios from "axios";


export default {
    getBeers(breweryId){
        return axios.get(`/beers/brewery/${breweryId}`);
    },
    updateBeer(beer){
        return axios.put(`/beers/`, beer);
    },
    addBeer(beer){
        return axios.post(`/beers/`,beer);
    },
    getBeerTypes(){
        return axios.get(`/beers/types/`);
    }
}