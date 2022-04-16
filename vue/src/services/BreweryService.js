import axios from "axios";


export default {
    getBreweryList(){
        return axios.get(`/breweries`);
    }, 
    createBrewery(brewery){
        return axios.post(`/breweries`,brewery)
    },
    updateBrewery(brewery){
        return axios.put(`/breweries`, brewery)
    }
}