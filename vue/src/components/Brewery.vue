<template>
  <div class="brewery">
    <img class="breweryLogo" :src="$store.state.activeBrewery.logo" alt="brewery logo" />
    <h2>{{ $store.state.activeBrewery.name }}</h2>
    <p>{{ $store.state.activeBrewery.phone }}</p>
    <p>{{ $store.state.activeBrewery.email }}</p>
    <p>{{ $store.state.activeBrewery.city }}</p>
  </div>
</template>

<script>
export default {
  name: "brewery",
  methods: {
    getBrewery() {
      this.$store.commit("SET_ACTIVE_BREWERY", this.$route.params.id);
    },
  },
  created() {
    this.getBrewery();
  },
};
</script>

<style scoped>

.breweryLogo {
    width: 15em;
  }


</style>