<template>
  <div class="beer-detail">
    <p>Inside beer detail</p>

    <img class="beerImg" :src="$store.state.activeBeer.imagePath" alt="beerImg" />
    <h2>{{ $store.state.activeBeer.name }}</h2>
    <p>Style: {{ $store.state.activeBeer.beerType }}</p>
    <p>{{ $store.state.activeBeer.description }}</p>
    <p>ABV: {{ $store.state.activeBeer.abv }}</p>
    <p>Price: ${{($store.state.activeBeer.price).toFixed(2)}}</p>
    <p>Average Rating: {{ $store.state.activeBeer.avgScore }}</p>
    <button v-on:click="updateBeer();">{{
        $store.state.activeBeer.active
          ? "Inactivate"
          : "Activate"
      }}</button>
  </div>
</template>

<script>
import BeerService from "../services/BeerService.js";
export default {
  name: "beer",
  methods: {
    getBeer() {
      this.$store.commit("SET_ACTIVE_BEER", this.$route.params.id);
    },
    updateBeer() {
        this.$store.commit("CHANGE_ACTIVE_BEER_STATUS");
        BeerService.updateBeer(this.$store.state.activeBeer)
        .then((response) => {
          if (response.status === 200) {
            alert("success");
          }
          this.getBeer();
        })
        .catch((error) => {
          this.handleErrorResponse(error, "updating");
        });
    },
     handleErrorResponse(error, verb) {
      if (error.response) {
        this.errorMsg =
          "Error " +
          verb +
          " beer. Response received was '" +
          error.response.statusText +
          "'.";
      } else if (error.request) {
        this.errorMsg =
          "Error " + verb + " beer. Server could not be reached.";
      } else {
        this.errorMsg =
          "Error " + verb + " beer. Request could not be created.";
      }
     },
  },
  
  created() {
    this.getBeer();
    this.beer = this.$store.state.activeBeer;
  }
};

</script>

<style>
.beerImg {
  width: 5%;
}

</style>