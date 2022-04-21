<template>
  <div>
      <button class="button-add-brewery">
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
.button-add-brewery{
  margin-bottom:2em;
}
</style>