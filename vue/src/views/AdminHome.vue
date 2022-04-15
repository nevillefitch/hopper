<template>
  <div>
      <button>
        <router-link :to="{name : 'AdminAddBrewery'}">Add Brewery</router-link> 
      </button>
      <brewery-list/>
  </div>
</template>

<script>
import BreweryList from '../components/BreweryList.vue'
export default {
  components: { BreweryList },

}
</script>

<style>

</style>