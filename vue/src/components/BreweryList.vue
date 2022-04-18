<template>
  <div class="brewery-list">
    <div
      v-for="brewery in activeBreweries"
      v-bind:key="brewery.breweryId"
      class="brewery-card"
    >
      <router-link
        tag="a"
        v-bind:to="{ name: 'brewery', params: { id: brewery.breweryId } }"
      >
        <div class="brewery-logo">
          <img class="breweryLogo" :src="brewery.logo" alt="brewery logo" />
        </div>

        <h2>{{ brewery.name }}</h2>
        <!-- <p>{{ brewery.phone }}</p> -->
        <!-- <p>{{ brewery.email }}</p> -->
        <p>{{ brewery.city }}, {{ brewery.state }}</p>
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
      return this.$store.state.breweries.filter((brewery) => brewery.active);
    },
  },
  created() {
    this.getBreweries();
  },
};
</script>

<style scoped>
.brewery-list {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-evenly;
}
.brewery-card {
  border: 2px solid black;
  border-radius: 10px;
  background-color: rgb(110, 160, 110);
  width: 200px;
  height: 200px;
  display: flex;
  justify-content: center;
  box-sizing: content-box;
  padding: 10px;
  margin: 6px;
}
.brewery-card:hover {
  background-color: rgb(182, 216, 182);
}
.brewery-logo {
  height: 100px;
  display: flex;
  justify-content: center;
}
a {
  text-decoration: none;
}
.breweryLogo {
  width: 10em;
}
h2, p {
 
  text-align: center;
   color: black;
}
h2{
 font-size: 1.5em;
}

</style>