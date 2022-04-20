<template>
  <form class="update-form" v-on:submit.prevent>
    <img
      class="breweryLogo"
      :src="$store.state.activeBrewery.logo"
      alt="brewery logo"
    />
    <div class="fields">
      <label for="logo">Brewery Logo URL: </label>
      <input name="logo" type="url" v-model="$store.state.activeBrewery.logo" />
    </div>
    <div class="fields">
      <label for="name">Brewery Name: </label>
      <input
        name="name"
        type="text"
        v-model="$store.state.activeBrewery.name"
      />
    </div>
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
    <div class="fields">
      <label for="history">History: </label>
      <textarea name="history" v-model="$store.state.activeBrewery.history" />
    </div>
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
    <div class="fields">
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
            alert("success");
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

<style>
/* Set grid areas */
form.update-form:nth-child(1)  {
  grid-area: logo;
}
form.update-form:nth-child(2) {
  grid-area: logo-url;
}
form.update-form:nth-child(3) {
  grid-area: name;
}
form.update-form:nth-child(4) {
  grid-area: phone;
}
form.update-form:nth-child(5) {
  grid-area: email;
}
form.update-form:nth-child(6) {
  grid-area: website;
}
form.update-form:nth-child(7) {
  grid-area: address;
}
form.update-form:nth-child(8) {
  grid-area: city;
}
form.update-form:nth-child(9) {
  grid-area: state;
}
form.update-form:nth-child(10) {
  grid-area: zip;
}
form.update-form:nth-child(11) {
  grid-area: history;
}
form.update-form:nth-child(12) {
  grid-area: hasFood;
}
form.update-form:nth-child(13) {
  grid-area: hours;
}
form.update-form div.submit{
  grid-area: submit-button
}
form.update-form:nth-child(15) {
  grid-area: update-button;
}

.breweryLogo {
  width: 15em;
}

img {
  width: 1em;
}

</style>