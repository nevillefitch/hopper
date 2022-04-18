<template>
  <div id="app">
    <img
      class="hopperLogo"
      src="../src/resources/logoAndName.png"
      alt="HopperLogo"
    />
    <div id="nav">
      <router-link class="home" v-bind:to="{name: 'home'}" v-if="($store.state.token == '' || $store.state.user.authorities[0].name == 'ROLE_USER')">Home</router-link>
      <router-link class="home" v-bind:to="{name: 'brewerHome', params: { id: breweryId }}" v-if="( $store.state.token != '' &&  $store.state.user.authorities[0].name == 'ROLE_BREWER')"> Home </router-link>
      <router-link class="home" v-bind:to="{name: 'AdminHome'}" v-if="($store.state.token != '' && $store.state.user.authorities[0].name == 'ROLE_ADMIN')"> Home </router-link>
      &nbsp;|&nbsp; 

      <router-link
        v-bind:to="{ name: 'logout' }"
        v-if="$store.state.token != ''"
        >Logout</router-link
      >

      <router-link v-bind:to="{ name: 'login' }" v-if="$store.state.token == ''"
        >Login</router-link
      >&nbsp;|&nbsp;

      <router-link
        v-bind:to="{ name: 'register' }"
        v-if="$store.state.token == ''"
        >Register</router-link
      >

      <!-- Not sure what order the nav should be, CSS designers figure it out please -->
      <span class="welcome"> 
        {{$store.state.token == "" ? "" : `Welcome, ${$store.state.user.username}` }}     
      </span>
    </div>

    <router-view />
  </div>
</template>

<script>
export default {
  methods: {
    getHomePath(){
              
              
              if (this.$store.state.user.authorities[0].name == "ROLE_USER") {
                alert('success')
              return "{name: 'home'}" ;}
            // } else if (
            //   this.$store.state.user.authorities[0].name == "ROLE_BREWER"
            // ) {
            //   let breweryId = this.getBreweryIdByOwnerId();
            //   this.$router.push({ name: "brewerHome", params: { id: breweryId } });
            // } else if (
            //   this.$store.state.user.authorities[0].name == "ROLE_ADMIN"
            // ) {
            //   this.$router.push({ name: "AdminHome" });
            // }
    },
    getBreweryIdByOwnerId() {
      for (let i = 0; i < this.$store.state.breweries.length; ++i) {
        if (
          this.$store.state.breweries[i].ownerId == this.$store.state.user.id
        ) {
          return (this.activeBreweryId =
            this.$store.state.breweries[i].breweryId);
        }
      }
    },
  }
}
</script>

<style scoped>
.hopperLogo {
  width: 25%;
}
</style>
