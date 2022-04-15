<template>
  <div>
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
</style>