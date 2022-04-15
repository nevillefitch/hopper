<template>
  <div class="beers">
    <p>inside beer list</p>
    <div
      v-for="beer in $store.state.activeBeers"
      v-bind:key="beer.beerId"
      class="beer"
    >
      <router-link v-bind:to="{name:'beerDetail', 
        params:{id:beer.beerId }} ">
        <img class="beerImg" :src="beer.imagePath" alt="beerImg" />
        <h2>{{ beer.name }}</h2>
        <p>{{ beer.beerType }}</p>
        <p>{{ beer.description }}</p>
        <p>{{ beer.abv }}</p>
        <p>{{ beer.price }}</p>
        <p>{{ beer.avgScore }}</p>
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
};
</script>

<style>
</style>