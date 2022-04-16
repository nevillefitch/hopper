<template>
  <form v-on:submit.prevent>
      <img
        class="breweryLogo"
        :src="$store.state.activeBrewery.logo"
        alt="brewery logo"/>
    <div class = "fields">
      <label for="logo">Brewery Logo URL: </label>
      <input name="logo" type="url" v-model="$store.state.activeBrewery.logo"/>
    </div>
    <div class = "fields">
      <label for="name">Brewery Name: </label>
      <input name="name" type="text" v-model="$store.state.activeBrewery.name"/>
    </div>
    <div class = "fields">
      <label for="phone">Phone: </label>
      <input name="phone" type = "tel" placeholder="123-456-7890" pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}"
      v-model="$store.state.activeBrewery.phone"/>
    </div>
    <div class = "fields">
      <label for="email">Email: </label>
      <input name="email" type="email" v-model="$store.state.activeBrewery.email"/>
    </div>
    <div class = "fields">
      <label for="address">Address: </label>
      <input name="address" type="text" v-model="$store.state.activeBrewery.streetAddress"/>
    </div>
    <div class = "fields">
      <label for="city">City: </label>
      <input name="city" type="text" v-model="$store.state.activeBrewery.city"/>
    </div>
    <div class = "fields">
      <label for="state">State: </label>
      <input name="state" type="text" v-model="$store.state.activeBrewery.state"/>
    </div>
    <div class = "fields">
      <label for="zipCode">Zip code: </label>
      <input name="zipCode" type="text" v-model="$store.state.activeBrewery.zip"/>
    </div>
    <div class = "fields">
      <label for="history">History: </label>
      <textarea name="history" v-model="$store.state.activeBrewery.history"/>
    </div>
    <div class = "fields">
      <label for="hasFoodButton">Does {{$store.state.activeBrewery.name}} have food? </label>
      <button name="hasFoodButton" v-on:click="updateHasFood();">{{
          $store.state.activeBrewery.hasFood
            ? "Make Food Unavailable"
            : "Make Food Available"
      }}</button>
    </div>
    <tr>
      <th>Day</th>
      <th>Open</th>
      <th>Close</th>
    </tr>
    <tr
    v-for="day in $store.state.activeBrewery.hours"
    v-bind:key="day.dayName"
    class="hours"
    >
    <td>{{day.dayName}} </td>
    <td><input type="time" v-model="day.open"/></td>
    <td><input type="time" v-model="day.close"/></td>
    </tr>
  <div class="submit">
      <button
        type="submit"
        v-on:click="updateBrewery();">
        Update
      </button>
    </div>
  </form>
</template>

<script>
import BreweryService from "../services/BreweryService.js"
export default {
  name: "update-brewery-form",
  methods: {
    updateHasFood() {
      this.$store.commit("CHANGE_BREWERY_HAS_FOOD")
    },
      updateBrewery() {
      BreweryService.updateBrewery(this.$store.state.activeBrewery)
      .then((response) => {
        if (response.status === 200) {
          this.$router.push({name: "brewerHome"})
          alert("success");
        }
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
          " brewery. Response received was '" +
          error.response.statusText +
          "'.";
      } else if (error.request) {
        this.errorMsg =
          "Error " + verb + " brewery. Server could not be reached.";
      } else {
        this.errorMsg =
          "Error " + verb + " brewery. Request could not be created.";
      }
     },
  }

}
</script>

<style>
.breweryLogo {
width: 15em;
}
img{
width: 1em;
}
</style>