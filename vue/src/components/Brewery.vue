<template>
  <div class="brewery">
    <img
      class="breweryLogo"
      :src="$store.state.activeBrewery.logo"
      alt="brewery logo"
    />
    <h2 class="title">{{ $store.state.activeBrewery.name }}</h2>
    <div class="contact-info">
      <p>{{ $store.state.activeBrewery.phone }}</p>
      <p>{{ $store.state.activeBrewery.email }}</p>
      <a :href="$store.state.activeBrewery.website" target="_blank">
        {{ $store.state.activeBrewery.name }} Homepage</a
      >
      <p>
        {{ $store.state.activeBrewery.streetAddress }}
        {{ $store.state.activeBrewery.city }},
        {{ $store.state.activeBrewery.state }}
        {{ $store.state.activeBrewery.zip }}
      </p>
    </div>
    <p class="about-us">{{ $store.state.activeBrewery.history }}</p>

    <div class="h-a-d">
      <div class="hours">
        <tr>
          <th>Day</th>
          <th>Open</th>
          <th>Close</th>
        </tr>
        <tr v-for="day in daysOpen" v-bind:key="day.dayName" class="hours">
          <td>{{ day.dayName }}</td>
          <td>{{ day.open }}</td>
          <td>{{ day.close }}</td>
        </tr>
      </div>
      <p>
        {{
          $store.state.activeBrewery.hasFood
            ? "Eats and drinks available!"
            : "Sorry, not even peanuts - no food menu."
        }}
      </p>
      <!-- Whoever is doing CSS: may want to set width in css  -->
      <div class="money">
      <img 
        src="@/resources/dollarSign.png"
        alt="$"
        v-for="d in getIntegerAvgPrice()"
        v-bind:key="d"
      />
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "brewery",
  methods: {
    getBrewery() {
      this.$store.commit("SET_ACTIVE_BREWERY", this.$route.params.id);
    },

    /*
    TODO: for final review: Do we all agree on these ratings?
      $ - avg beer price < $5.00
      $$ - avg beer price between $5.00 and $9.00  (inclusive)
      $$$ - avg beer price > $9.00
       */
    getIntegerAvgPrice() {
      let avgPriceRating = 1;
      let dollarPrice = this.$store.state.activeBrewery.avgPrice;
      if (dollarPrice >= 5.0 && dollarPrice <= 9.0) {
        avgPriceRating = 2;
      } else if (dollarPrice > 9) {
        avgPriceRating = 3;
      }

      return avgPriceRating;
    },
  },
  computed: {
    daysOpen() {
      return this.$store.state.activeBrewery.hours.filter(
        (day) => day.open != day.close
      );
    },
  },
  created() {
    this.getBrewery();
  },
};
</script>

<style scoped>
.brewery {
  background-image: url("https://wallpaper.dog/large/20483358.jpg");
  background-repeat: no-repeat;
  background-attachment: fixed;
  background-size: cover;
  
} 
.breweryLogo {
  width: 15em;
}
img {
  width: 2em;
  background-color: white;
  border-radius: 1em;
}

td {
  padding: 4px;
}
.brewery {
  display: grid;
  grid-template-areas:
    "logo title hours"
    "logo contact hours"
    "about picture picture"
    "about picture picture";
  grid-template-columns: repeat(3, 1fr);

  justify-items: center;
  align-items: center;
}
.breweryLogo {
  grid-area: logo;
}
.contact-info {
  grid-area: contact;
  text-align: center;
  /* border: rgb(18, 82, 47) solid 3px;
  background-color: white;
  border-radius: 15px;
  padding: 5px; */
  color: white;
  margin-top:-30px;
}
a {
  color: white;
}
a:hover{
  color: grey;
}
p {
  text-align: center;
}
.h-a-d {
  color: white;
  grid-area: hours;
  justify-self: right;
  margin-right: 50px;
  justify-content: center;
  flex-direction: column;
  align-items: center;
  display: flex;
  border-radius: 15px;
  border: rgb(6, 66, 33) solid 3px;
  box-shadow: 10px 10px rgba(22, 168, 29, 0.15);
  padding: 5px;
}

.about-us {
  color: white;
  border: rgb(6, 66, 33) solid 3px;
  /* background-color: white; */
  border-radius: 15px;
  grid-area: about;
  box-shadow: 10px 10px rgba(22, 168, 29, 0.15);
  
  padding: 5px;
}

.title {
  text-align: center;
  color: white;
  grid-area: title;
  font-size: 40px;
}


</style>