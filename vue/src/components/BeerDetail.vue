<template>
  <div class="beer-detail">
    <p>Inside beer detail</p>

    <img class="beerImg" :src="beer.imagePath" alt="beerImg" />
    <h2>{{ beer.name }}</h2>
    <p>{{ beer.beerType }}</p>
    <p>{{ beer.description }}</p>
    <p>{{ beer.abv }}</p>
    <p>{{ beer.price }}</p>
    <p>{{ beer.avgScore }}</p>
  </div>
</template>

<script>
export default {};
</script>

<style>
</style>