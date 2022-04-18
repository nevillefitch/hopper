<template>
  <div class="beers">
   
    <div
      v-for="beer in $store.state.activeBeers"
      v-bind:key="beer.beerId"
      class="beer"
    >

      <router-link v-if="isLoggedInBrewersBrewery" 
      v-bind:to="{name:'brewerBeer', 
        params:{id:beer.beerId }} ">
        <img class="beerImg" :src="beer.imagePath" alt="beerImg" />
        <h2>{{ beer.name }}</h2>
        <p>{{ beer.beerType }}</p>
        <p>ABV {{ beer.abv }}</p>
      </router-link>

      <router-link v-if="!isLoggedInBrewersBrewery"
      v-bind:to="{name:'beerDetail', 
        params:{id:beer.beerId }} ">
        <img class="beerImg" :src="beer.imagePath" alt="beerImg" />
        <h2>{{ beer.name }}</h2>
        <p>{{ beer.beerType }}</p>
        <p>ABV {{ beer.abv }}</p>
      </router-link>
    </div>
  </div>
</template>

<script>
import BeerService from "../services/BeerService.js";
export default {
  name: "beer-list",
  methods: {
    getBeers() {
      BeerService.getBeers(this.$route.params.id).then((response) => {
        this.$store.commit("SET_ACTIVE_BEERS", response.data);
      });
    },
  },
  created() {
    this.getBeers();
  },
  computed: {
    isLoggedInBrewersBrewery() {
         return this.$store.state.activeBrewery.ownerId == this.$store.state.user.id
    },
  }
};
</script>

<style>
</style>