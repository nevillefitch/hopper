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
  </div>
</template>

<script>
export default {
  name: "beer",
  methods: {
    getBeer() {
      this.$store.commit("SET_ACTIVE_BEER", this.$route.params.id);
    }
  },
  created() {
    this.getBeer();
  }
};

</script>

<style>
.beerImg {
  width: 5%;
}

</style>