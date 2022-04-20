<template>
<div class="box">
  <form v-on:submit.prevent>
    <div class="field">
      <label for="name">Brewery Name: </label>
      <input type="text" name="name" v-model="brewery.name" />
    </div>
    <div class="field">
      <label for="ownerId">Brewery Username: </label>
      <select name="ownerId" v-model="brewery.ownerId">

        <option value="0"></option>
        <option
          v-for="user in this.users.data"
          v-bind:key="user.id"
          :value="user.id"
        >
          {{ user.username }}
        </option>
      </select>
    </div>
    <div class="actions">
      <button
        type="submit"
        v-on:click="
          upgradeUser();
          addBrewery();
        "
      >
        Add Brewery
      </button>
    </div>
  </form>
  </div>
</template>

<script>
import BreweryService from "../services/BreweryService.js";
import AuthService from "../services/AuthService.js";
export default {
  name: "create-brewery",
  data() {
    return {
      brewery: {
        name: "",
        ownerId: "",
      },
      users: [],
      beerLovers: [],
    };
  },
  created() {
    AuthService.getUsers().then((response) => {
      this.users = response;
   
    });
  },
  computed: {
    beerLoverFilter() {
      return this.users.data.filter(user => user.authorities[0].name === 'ROLE_ADMIN');
    },
  },
  methods: {
    addBrewery() {
      BreweryService.createBrewery(this.brewery)
        .then((response) => {
          if (response.status === 201) {
            this.$router.push({ name: "AdminHome" });
          }
        })
        .catch((error) => {
          this.handleErrorResponse(error, "creating");
        });
    },
    upgradeUser() {
      AuthService.updateBeerLoverToBrewer(this.brewery.ownerId).then(
        (response) => {
          //TODO: is this alert necessary? do we need a catch instead?
          if (response.status === 200) {
            "success";
          }
        })
        .catch((error) => {
          this.handleErrorResponse(error, "finding user to upgrade to owner of")
        })
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
  },
};
</script>

<style>
.box {
  height: 20%;
}
</style>