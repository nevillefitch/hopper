import axios from "axios";
const http = axios.create({
    baseURL: "http://localhost:3000/breweries"
});

export default {
    getBreweryList(){
        return http.get(``);
    }, 
    createBrewery(brewery){
        return http.post(``,brewery)
    }
}