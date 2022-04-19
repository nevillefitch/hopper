<template>
  <div id="login-div" class="text-center">
    <form @submit.prevent="login" id="login-form">
      <h1>Please Login</h1>
      <div class="alert alert-danger" role="alert" v-if="invalidCredentials">
        Invalid username and password!
      </div>
      <div
        class="alert alert-success"
        role="alert"
        v-if="this.$route.query.registration"
      >
        Thank you for registering, please login.
      </div>
      <label for="username" class="form-label">Username:</label>
      <input
        type="text"
        id="username"
        class="form-control"
        placeholder="Username"
        v-model="user.username"
        required
        autofocus
      />
      <label for="password" class="form-label">Password:</label>
      <input
        type="password"
        id="password"
        class="form-control"
        placeholder="Password"
        v-model="user.password"
        required
      />
      <button class="form-button" id="login" type="submit">Login</button>

      <label id="need-account" for="register" class="button-label">Need an account?</label>
      <button class="form-button" id="register" name="register">
        <router-link :to="{ name: 'register' }">Register</router-link>
      </button>
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
        password: "",
      },
      activeBreweryId: "",
      invalidCredentials: false,
    };
  },
  //TODO: refactor to activeBrewery
  //created() {
  //let breweryId = this.getBreweryIdByOwnerId();
  //  const breweryId = this.$route.params.id;
  //this.$store.commit("SET_ACTIVE_BREWERY", breweryId);
  //},
  methods: {
    login() {
      authService
        .login(this.user)
        .then((response) => {
          if (response.status == 200) {
            this.$store.commit("SET_AUTH_TOKEN", response.data.token);
            this.$store.commit("SET_USER", response.data.user);
            if (this.$store.state.user.authorities[0].name == "ROLE_USER") {
              this.$router.push({ name: "home" });
            } else if (
              this.$store.state.user.authorities[0].name == "ROLE_BREWER"
            ) {
              this.updateBrewerHomeBrewery();
              this.$router.push({ name: "brewerHome", params: { id: this.$store.state.brewerHomeBrewery } });
            } else if (
              this.$store.state.user.authorities[0].name == "ROLE_ADMIN"
            ) {
              this.$router.push({ name: "AdminHome" });
            }
            // if brewer, route to brewer homepage
          }
          //this.$router.push({name: 'home'});
        })
        .catch((error) => {
          const response = error.response;
          console.log(response);

          if (response.status === 401) {
            this.invalidCredentials = true;
          }
        });
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
    updateBrewerHomeBrewery() {
      this.$store.commit("SET_BREWER_HOME_BREWERY", this.getBreweryIdByOwnerId());
    }
  },
};
</script>
<style>

/*forms */
#create-brewery-form, #register-form, #login-form {
  width: 200px;
  height: 400px;
  background-color: rgb(110, 160, 110);
  border-radius: 4%;
  margin: 20px auto;
  padding: 1em;
 
}
#register-form h1, #login-form h1, #create-brewery-form h1{
  font-size: 1.2em;
}
.form-label{
  display: block;
  font-weight: bold;
   margin: 2em 0 0.4em 0;
  text-align: left;
}

input.form-control {
  background-color: #c2c0c0;
}

label#need-account, label#already-have-account{
  display:block;
  text-align: center;
  margin: 2em 0 0 0;
}
button{
  border-radius: 20%;
  background-color: #747272;
  margin: 1em;

}
.form-button{
  display: block;
  margin: 1em auto;
  
}
#login-div{ 
  background-image: url("https://wallpaperaccess.com/full/5422418.jpg");
  background-repeat: no-repeat;
  background-attachment: fixed;
  background-size: cover;
  padding: 20px;
}
</style>
