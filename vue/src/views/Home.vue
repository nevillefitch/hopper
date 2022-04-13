<template>
  <div class="home">
    <h1>Home</h1>
    <p>You must NOT be authenticated to see this</p>

    <p 
    v-bind:to =" this.$store.state.user" 
    v-bind:key="this.$store.state.user.role" >
    role:{{user.role}}
    </p>
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
