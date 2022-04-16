<template>
  <div>
    <form v-on:submit.prevent>
      <div class="field">
        <label for="name">Name: </label>
        <input type="text" name="name" id="name" v-model="beer.name" />
      </div>
      <div class="field">
        <label for="imagePath">Image URL: </label>
        <input
          type="text"
          name="imagePath"
          id="imagePath"
          v-model="beer.imagePath"
        />
      </div>
      <div class="field">
        <label for="description">Beer Description: </label>
        <input
          type="text"
          name="description"
          id="description"
          v-model="beer.description"
        />
      </div>
      <div class="field">
        <label for="price">Beer Price: </label>
        <input type="text" name="price" id="price" v-model="beer.price" />
      </div>
      <div class="field">
        <label for="abv">ABV: </label>
        <input type="text" name="abv" id="imagePath" v-model="beer.abv" />
      </div>
      <select name="beerTypeId" v-model="beer.beerTypeId">
        <option value="0"></option>
        <option
          v-for="beerType in this.beerTypes.data"
          v-bind:key="beerType.beerTypeId"
          :value="beerType.beerTypeId"
        >
          {{ beerType.typeName }}
        </option>
      </select>
      <div class="actions">
        <button type="submit" v-on:click="addBeer()">Add Beer</button>
      </div>
    </form>
  </div>
</template>



<script>
import BeerService from "../services/BeerService.js";
export default {
  name: "create-beer",
  data() {
    return {
      beer: {
        breweryId: "",
        name: "",
        imagePath: "",
        description: "",
        price: "",
        abv: "",
        active: true,
        beerTypeId: "",
      },
      beerTypes: [],
    };
  },
  methods: {
    addBeer() {
      BeerService.addBeer(this.beer)
        .then((response) => {
          if (response.status === 201) {
            this.$router.push({ name: "brewerHome" });
          }
        })
        .catch((error) => {
          this.handleErrorResponse(error, "creating");
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
    this.beer.breweryId = this.$store.state.activeBrewery.breweryId;
    BeerService.getBeerTypes().then((response) => {
      this.beerTypes = response;
    });
  },
};
</script>

<style>
</style>