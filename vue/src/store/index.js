import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
//import  find  from 'core-js/core/array'

Vue.use(Vuex)

/*
 * The authorization header is set for axios when you login but what happens when you come back or
 * the page is refreshed. When that happens you need to check for the token in local storage and if it
 * exists you should set the header so that it will be attached to each request
 */
const currentToken = localStorage.getItem('token')
const currentUser = JSON.parse(localStorage.getItem('user'));
//TODO: add activeBrewery
//const activeBrewery = 

if(currentToken != null) {
  axios.defaults.headers.common['Authorization'] = `Bearer ${currentToken}`;
}

export default new Vuex.Store({
  state: {
    token: currentToken || '',
    user: currentUser || {},
    breweries: [],
    activeBrewery: '',
    activeBeers: [],
    activeBeer: '',
    activeReviews: [],
  },
  mutations: {
    SET_AUTH_TOKEN(state, token) {
      state.token = token;
      localStorage.setItem('token', token);
      axios.defaults.headers.common['Authorization'] = `Bearer ${token}`
    },
    SET_USER(state, user) {
      state.user = user;
      localStorage.setItem('user',JSON.stringify(user));
    },
    LOGOUT(state) {
      localStorage.removeItem('token');
      localStorage.removeItem('user');
      state.token = '';
      state.user = {};
      axios.defaults.headers.common = {};
    },
    SET_BREWERIES(state, breweries) {
      state.breweries = breweries;
    }, 
    SET_ACTIVE_BREWERY(state, breweryId) {
      state.activeBrewery = state.breweries.find(brewery => brewery.breweryId == breweryId)
    },
    SET_ACTIVE_BEERS(state, beers){
      state.activeBeers = beers;
    },
    SET_ACTIVE_BEER(state, beerId) {
      state.activeBeer = state.activeBeers.find(beer => beer.beerId == beerId)
    },
    SET_ACTIVE_REVIEWS(state, reviews){
      state.activeReviews = reviews;
    },
    CHANGE_ACTIVE_BEER_STATUS(state){
      state.activeBeer.active = !state.activeBeer.active;
    },
    CHANGE_BREWERY_HAS_FOOD(state){
      state.activeBrewery.hasFood = !state.activeBrewery.hasFood;
    }
  }
})
