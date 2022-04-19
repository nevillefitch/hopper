<template>
  <div class="beer">
    <div class="update-button">
      <button class="button">
        <router-link
          tag="a"
          v-bind:to="{
            name: 'breweryUpdate',
            params: { id: this.$route.params.id },
          }"
          >Update Brewery</router-link
        >
      </button>

      <button class="button">
        <router-link
          tag="a"
          v-bind:to="{
            name: 'addBeer',
            params: { id: $store.state.activeBrewery.breweryId },
          }"
          >Add Beer</router-link
        >
      </button>
    </div>
    <brewery />
    <beer-list />
  </div>
</template>

<script>
import BeerList from "../components/BeerList.vue";
import Brewery from "../components/Brewery.vue";

export default {
  components: { Brewery, BeerList },
};
</script>

<style>
.update-button {
  display: flex;
  flex-direction: row;
  justify-content: flex-end;
}

.button {
  color: white;
  border: 2px solid rgb(6, 66, 33);
  border-radius: 5px;
  padding: 10px 10px;
  display: inline-block;
  font-family: "Lucida Console", Monaco, monospace;
  font-size: 14px;
  margin-right: 5px;
  cursor: pointer;
  box-shadow: inset 0 0 0 0 white;
  -webkit-transition: ease-out 0.4s;
  -moz-transition: ease-out 0.4s;
  transition: ease-out 0.4s;
  text-decoration: none;
}
.button:hover {
  box-shadow: inset 400px 0 0 0 #2a7e3f;
}
a {
  color: black;
  text-decoration: none;
}
.beer {
  background-image: url("https://wallpaper.dog/large/20483358.jpg");
  background-repeat: no-repeat;
  background-attachment: fixed;
  background-size: cover;
}
</style>