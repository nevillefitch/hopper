<template>
  <div id="app">
    <img class="hopperLogo" src="../src/resources/logoAndName.png" alt="HopperLogo" >
    <div id="nav">
      <router-link v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;|&nbsp;
      <router-link
        v-bind:to="{ name: 'logout' }"
        v-if="$store.state.token != ''"
        >Logout</router-link
      >

      <router-link 
        v-bind:to="{ name: 'login' }" 
        v-if="$store.state.token == ''"
        >Login</router-link
      >&nbsp;|&nbsp;

      <router-link 
      v-bind:to="{ name: 'register' }"
       v-if="$store.state.token == ''"
      >Register</router-link>
    </div>

    <router-view />

    
  </div>
</template>

<style scoped>
  .hopperLogo {
    width: 25%;
  }
</style>
