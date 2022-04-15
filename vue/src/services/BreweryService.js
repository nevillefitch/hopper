import axios from "axios";


export default {
    getBreweryList(){
        return axios.get(`/breweries`);
    }, 
    createBrewery(brewery){
        return axios.post(`/breweries`,brewery)
    }
}