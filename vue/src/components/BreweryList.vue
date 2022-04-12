<template>
  <div class="brewery-list">
      <p>test test test</p>
      <div v-for="brewery in breweries" v-bind:key = "brewery.breweryId" class = "brewery">
          <img :src="brewery.logo" alt="brewery logo">
          <h2>{{brewery.name}}</h2>
          <p>{{brewery.phone}}</p>
          <p>{{brewery.email}}</p>
          <p>{{brewery.city}}</p>
      </div>
  </div>
</template>

<script>
import BreweryService from "../services/BreweryService.js";
export default {
  name: "brewery-list",
  data() {
      return {
          breweries: []
      }
  },
  created() {
      BreweryService.getBreweryList().then((response) => {
          this.breweries = response.data;
      })
  }
};
</script>

<style>
</style>