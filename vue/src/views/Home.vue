<template>
  <div class="home">
    <h1>Home</h1>
    <p>You must NOT be authenticated to see this</p>
    <!-- <p 
    v-bind:to ="$store.state.user.authorities[0]" 
    v-bind:key="$store.state.user.authorities.id" >
    role:{{$store.state.user.authorities[0].name}}
    </p> -->

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
