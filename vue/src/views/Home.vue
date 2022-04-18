<template>
  <div class="home">
    <brewery-list></brewery-list>
  </div>
</template>

<script>
import BreweryList from '@/components/BreweryList.vue';
export default {
  name: "home",
  components:{
    BreweryList
  }
};
</script>
