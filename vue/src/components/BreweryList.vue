<template>
  <div class="brewery-list">
    <p>test test test</p>
    <div
      v-for="brewery in $store.state.breweries"
      v-bind:key="brewery.breweryId"
      class="brewery"
    >
      <img :src="brewery.logo" alt="brewery logo" />
      <h2>{{ brewery.name }}</h2>
      <p>{{ brewery.phone }}</p>
      <p>{{ brewery.email }}</p>
      <p>{{ brewery.city }}</p>
    </div>
  </div>
</template>

<script>
import BreweryService from "../services/BreweryService.js";
export default {
  name: "brewery-list",
  methods: {
    getBreweries() {
      BreweryService.getBreweryList()
        .then((response) => {
          this.$store.commit("SET_BREWERIES", response.data);
        })
        .catch((error) => {
          if (error.response) {
            this.errorMsg =
              "Error retrieving breweries. Error: " + error.response.statusText;
          } else if (error.request) {
            this.errorMsg =
              "Error submitting request for breweries. Cannot reach the server.";
          } else {
            this.errorMsg =
              "Unknown error. Request could not be completed.";
          }
        });
    },
  },
  created() {
    this.getBreweries();
  },
};
</script>

<style>
</style>