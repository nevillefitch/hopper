<template>
  <div>
    <button>
      <router-link v-bind:to="{name: 'breweryUpdate', params:{id:this.$route.params.id}}">Update Brewery</router-link>
    </button>
    <brewery />
    <router-link v-bind:to="{name: 'addBeer'}">Add Beer</router-link>
    <beer-list/>
  </div>
</template>

<script>
import BeerList from '../components/BeerList.vue'
import Brewery from '../components/Brewery.vue'

export default {
  components: { Brewery, BeerList },

}
</script>

<style>

</style>