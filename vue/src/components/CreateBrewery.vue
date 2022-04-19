<template>
  <div id="create-brewery-div">
    <form id="create-brewery-form" v-on:submit.prevent>
      <h1>Add Brewery</h1>
      <div class="field">
        <label class="form-label" for="name">Brewery Name: </label>
        <input type="text" name="name" placeholder="Brewery Name" v-model="brewery.name" />
      </div>
      <div class="field">
        <label class="form-label" for="ownerId">Brewer Username: </label>
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
          class="form-button"
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
      return this.users.data.filter(
        (user) => user.authorities[0].name === "ROLE_ADMIN"
      );
    },
  },
  methods: {
    addBrewery() {
      BreweryService.createBrewery(this.brewery)
        .then((response) => {
          if (response.status === 201) {
            this.$router.push({ name: "AdminHome" });
            alert("Brewery Created");
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
            alert("updateduserId");
          }
        }
      );
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
#create-brewery-div {
  background-image: url("https://breweriesinpa.com/wp-content/uploads/2019/01/1-5.jpg");
  background-repeat: no-repeat;
  background-attachment: fixed;
  background-size: cover;
}
</style>