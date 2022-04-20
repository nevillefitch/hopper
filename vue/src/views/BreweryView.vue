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
  background-image: url(../../src/resources/41587_2021_1202_Figa_HTMLgrey.jpg);
  background-repeat: no-repeat;
  background-attachment: fixed;
  background-size: cover;
}
</style>