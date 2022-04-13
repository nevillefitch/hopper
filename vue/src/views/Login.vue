<template>
  <div id="login" class="text-center">
    <form class="form-signin" @submit.prevent="login">
      <h1 class="h3 mb-3 font-weight-normal">Please Sign In</h1>
      <div class="alert alert-danger" role="alert" v-if="invalidCredentials">
        Invalid username and password!
      </div>
      <div
        class="alert alert-success"
        role="alert"
        v-if="this.$route.query.registration"
      >
        Thank you for registering, please sign in.
      </div>
      <label for="username" class="sr-only">Username</label>
      <input
        type="text"
        id="username"
        class="form-control"
        placeholder="Username"
        v-model="user.username"
        required
        autofocus
      />
      <label for="password" class="sr-only">Password</label>
      <input
        type="password"
        id="password"
        class="form-control"
        placeholder="Password"
        v-model="user.password"
        required
      />
      <router-link :to="{ name: 'register' }">Need an account?</router-link>
      <button type="submit">Sign in</button>
    </form>
  </div>
</template>

<script>
import authService from "../services/AuthService";

export default {
  name: "login",
  components: {},
  data() {
    return {
      user: {
        username: "",
        password: ""
      },
      activeBreweryId: "",
      invalidCredentials: false
    };
  },
  //TODO: refactor to activeBrewery
   created() {
    const activeBookISBN = this.$route.params.isbn;
    this.$store.commit("SET_ACTIVE_BOOK", activeBookISBN);
  },
  methods: {
    
    login() {
      authService
        .login(this.user)
        .then(response => {
          if (response.status == 200) {
            this.$store.commit("SET_AUTH_TOKEN", response.data.token);
            this.$store.commit("SET_USER", response.data.user);
            if (this.$store.state.user.authorities[0].name == "ROLE_USER"){
              alert("test alert");
            this.$router.push({name: 'home'});
            }
            else if (this.$store.state.user.authorities[0].name == "ROLE_BREWER"){
              let breweryId = this.getBreweryIdByOwnerId();
              this.$router.push({name: 'brewery', params: {id: breweryId}});
            }
            else if (this.$store.state.user.authorities[0].name == "ROLE_ADMIN"){
              this.$router.push({name: 'home'});
            }
            // if brewer, route to brewer homepage
          }
          //this.$router.push({name: 'home'});
          
        })
        .catch(error => {
          const response = error.response;
          console.log(response);

          if (response.status === 401) {
            this.invalidCredentials = true;
          }
        });
    },

    getBreweryIdByOwnerId() {
      for(let i = 0; i<this.$store.state.breweries.length; ++i) {
        if (this.$store.state.breweries[i].ownerId == this.$store.state.user.id) {
          this.activeBreweryId = this.$store.state.breweries[i].breweryId;
          break;
        } 
      }
    }
  }
};
</script>
