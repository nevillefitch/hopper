<template>
  <div id="app">
    <header>
      <img
        class="hopperLogo"
        src="../src/resources/logoAndName.png"
        alt="HopperLogo"
      />
    </header>
    <div id="nav">
      <!-- would like to make this one router link that references a method... if there is time -DMB -->
      <router-link
        class="home"
        v-bind:to="{ name: 'home' }"
        v-if="
          $store.state.token == '' ||
          $store.state.user.authorities[0].name == 'ROLE_USER'
        "
        >Home</router-link
      >
      <router-link
        class="home"
        v-bind:to="{
          name: 'brewerHome',
          params: { id: $store.state.activeBrewery.breweryId },
        }"
        v-if="
          $store.state.token != '' &&
          $store.state.user.authorities[0].name == 'ROLE_BREWER'
        "
        >Brewer Page
      </router-link>
      <router-link
        class="home"
        v-bind:to="{ name: 'AdminHome' }"
        v-if="
          $store.state.token != '' &&
          $store.state.user.authorities[0].name == 'ROLE_ADMIN'
        "
      >
        Home
      </router-link>
      &nbsp;|&nbsp;

      <router-link
        class="home"
        v-bind:to="{ name: 'home' }"
        v-if="
          $store.state.token != '' &&
          $store.state.user.authorities[0].name == 'ROLE_BREWER'
        "
        >Breweries
        &nbsp;|&nbsp;
      </router-link>
      

      <router-link
        v-bind:to="{ name: 'logout' }"
        v-if="$store.state.token != ''"
        id="logout">Logout</router-link
      >

      <router-link id="login" v-bind:to="{ name: 'login' }" v-if="$store.state.token == ''"
        >Login</router-link
      >&nbsp;|&nbsp;

      <router-link
        id="register"
        v-bind:to="{ name: 'register' }"
        v-if="$store.state.token == ''"
        >Register</router-link
      >

      <!-- Not sure what order the nav should be, CSS designers figure it out please -->
      <span class="welcome">
        {{
          $store.state.token == ""
            ? ""
            : `Welcome, ${$store.state.user.username}`
        }}
      </span>
    </div>

    <router-view />
    <footer>
      <div>Copyright © NLR Cohort 6 Hopper Capstone</div>
      <div>Isaac - Neville - Luigi - Logan - Devin</div>
    </footer>
  </div>
</template>

<script>
export default {
  methods: {
    getBreweryIdByOwnerId() {
      for (let i = 0; i < this.$store.state.breweries.length; ++i) {
        if (
          this.$store.state.breweries[i].ownerId == this.$store.state.user.id
        ) {
          let id = (this.activeBreweryId =
            this.$store.state.breweries[i].breweryId);
          this.$store.commit("SET_ACTIVE_BREWERY", id);
        }
      }
    },
  },
  created() {
    this.getBreweryIdByOwnerId();
  },
};
</script>

<style>
body {
  background-color: rgb(230, 255, 246);
  margin-left:0;
  margin-right:0;
}
header{
  display: flex;
  width: 100%;
  background-color: rgb(110, 160, 110);
  justify-content: center;
}
#nav{
  border: 1pm solid black;



}
.hopperLogo {
  width: 35%;
  padding: 1em;
}

footer {
  display: flex;
  flex-direction: column;
  height: 5em;
  background-color: rgb(110, 160, 110);
  justify-content: center;
  align-content: center;
  align-items: center;
}

</style>
