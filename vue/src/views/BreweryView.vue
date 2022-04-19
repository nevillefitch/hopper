<template>
  <div class="beer">
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
.beer {
  background-image: url("https://wallpaper.dog/large/20483358.jpg");
  background-repeat: no-repeat;
  background-attachment: fixed;
  background-size: cover;
}
</style>