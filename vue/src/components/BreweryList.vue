<template>
  <div class="brewery-list">
       <div
      v-for="brewery in activeBreweries"
      v-bind:key="brewery.breweryId"
      class="brewery-card"
    >
      <router-link v-bind:to="{name: 'brewery', 
                  params:{ id:brewery.breweryId} }">
        <img class="breweryLogo" :src="brewery.logo" alt="brewery logo" />
        <h2>{{ brewery.name }}</h2>
        <p>{{ brewery.phone }}</p>
        <p>{{ brewery.email }}</p>
        <p>{{ brewery.city }}</p>
      </router-link>
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
            this.errorMsg = "Unknown error. Request could not be completed.";
          }
        });
    },
  },
  computed: {
     activeBreweries() {
      return this.$store.state.breweries.filter(brewery => brewery.active);
    }
  },
  created() {
    this.getBreweries();
  },
};
</script>

<style scoped>
.brewery-card {
  border: 1px solid black;
}

.breweryLogo {
  width: 10em;
}
</style>