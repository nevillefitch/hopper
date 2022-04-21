<template>
  <form class="update-form" v-on:submit.prevent>
    <img
      class="update-form-brewery-logo"
      :src="$store.state.activeBrewery.logo"
      alt="brewery logo"
    />
    
    <div class="logo-name">
      <h2 class="title">{{ $store.state.activeBrewery.name }}</h2>
      <div>
        <label for="logo">Brewery Logo URL: </label>
        <input
          name="logo"
          type="url"
          v-model="$store.state.activeBrewery.logo"
        />
      </div>
      <div>
        <label for="name">Brewery Name: </label>
        <input
          name="name"
          type="text"
          v-model="$store.state.activeBrewery.name"
        />
      </div>
    </div>
    <div class="contact-info">
      <div class="fields">
        <label for="phone">Phone: </label>
        <input
          name="phone"
          type="tel"
          placeholder="123-456-7890"
          pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}"
          v-model="$store.state.activeBrewery.phone"
        />
      </div>

      <div class="fields">
        <label for="email">Email: </label>
        <input
          name="email"
          type="email"
          v-model="$store.state.activeBrewery.email"
        />
      </div>
      <div class="fields">
        <label for="website">Website: </label>
        <input
          name="website"
          type="url"
          v-model="$store.state.activeBrewery.website"
        />
      </div>
      <div class="fields">
        <label for="address">Address: </label>
        <input
          name="address"
          type="text"
          v-model="$store.state.activeBrewery.streetAddress"
        />
      </div>
      <div class="fields">
        <label for="city">City: </label>
        <input
          name="city"
          type="text"
          v-model="$store.state.activeBrewery.city"
        />
      </div>
      <div class="fields">
        <label for="state">State: </label>
        <input
          name="state"
          type="text"
          v-model="$store.state.activeBrewery.state"
        />
      </div>
      <div class="fields">
        <label for="zipCode">Zip code: </label>
        <input
          name="zipCode"
          type="text"
          v-model="$store.state.activeBrewery.zip"
        />
      </div>
    </div>
    <div class="about-us">
      <label for="history">History: </label>
      <textarea id="history" name="history" v-model="$store.state.activeBrewery.history" />
    </div>
    <div class="misc">
      <div class="fields">
        <label for="hasFoodButton"
          >Does {{ $store.state.activeBrewery.name }} have food?
        </label>
        <button name="hasFoodButton" v-on:click="updateHasFood()">
          {{
            $store.state.activeBrewery.hasFood
              ? "Make Food Unavailable"
              : "Make Food Available"
          }}
        </button>
      </div>
      <div class="fields" id="update-hours-section">
        <tr>
          <th>Day</th>
          <th>Open</th>
          <th>Close</th>
        </tr>
        <tr
          v-for="day in $store.state.activeBrewery.hours"
          v-bind:key="day.dayName"
          class="hours"
        >
          <td>{{ day.dayName }}</td>
          <td><input type="time" v-model="day.open" /></td>
          <td><input type="time" v-model="day.close" /></td>
        </tr>
        <p>
          To indicate closed for the day please set both close and open times to
          12:00 am.
        </p>
      </div>

      <div class="button-area">
      <div class="submit">
        <button type="submit" v-on:click="updateBrewery()">Update</button>
      </div>
      <div v-if="!this.$store.state.activeBrewery.active" class="fields">
        <button
          name="activeButton"
          v-on:click="
            updateActiveStatus();
            updateBrewery();
          "
        >
          Activate Brewery
        </button>
      </div>
    </div>
    </div>
    
  </form>
</template>

<script>
import BreweryService from "../services/BreweryService.js";
export default {
  name: "update-brewery-form",
  methods: {
    updateHasFood() {
      this.$store.commit("CHANGE_BREWERY_HAS_FOOD");
    },
    updateActiveStatus() {
      this.$store.commit("CHANGE_BREWERY_ACTIVE_STATUS");
    },
    updateBrewery() {
      BreweryService.updateBrewery(this.$store.state.activeBrewery)
        .then((response) => {
          if (response.status === 200) {
            this.$router.push({ name: "brewerHome" });
          }
        })
        .catch((error) => {
          this.handleErrorResponse(error, "updating");
        });
    },
    handleErrorResponse(error, verb) {
      if (error.response) {
        this.errorMsg =
          "Error " +
          verb +
          " brewery. Response received was '" +
          error.response.statusText +
          "'.";
      } else if (error.request) {
        this.errorMsg =
          "Error " + verb + " brewery. Server could not be reached.";
      } else {
        this.errorMsg =
          "Error " + verb + " brewery. Request could not be created.";
      }
    },
  },
};
</script>

<style scoped>
/* Set grid areas */
.update-form {
  display: grid;
  grid-template-areas:
    "title . misc"
    "about-us contact-info misc"
    "about-us contact-info .";
  margin: 2em auto;
  padding: 2em;
  border-radius: 10%;
  background-color: rgba(129, 167, 129, .7);
  width: 80vw;
  height: 72vh;
  /* grid-template-columns: repeat(3, 1fr);*/
}

/* .update-form-brewery-logo {
  grid-area: update-form-brewery-logo;
}
.logo-name {
  grid-area: logo-name;
} */
.contact-info {
  grid-area: contact-info;
}
.about-us {
  grid-area: about-us;
  
}
.logo-title {
  grid-area: title;
}
.misc {
  grid-area: misc;
}
.button-area {
  grid-area: button-area;
}
.update-form-brewery-logo {
  width: 15em;
} 
#history {
height: 315px;
width: 310px;
}
.update-form label {
  display: block;
  
}
.update-form input {
  margin: 0 0 .8em 0;
}
#update-hours-section{
  margin: 2em 0 0 0;
}

</style>