<template>
  <div class="brewery">
    <img
      class="breweryLogo"
      :src="$store.state.activeBrewery.logo"
      alt="brewery logo"
    />
    <h2>{{ $store.state.activeBrewery.name }}</h2>
    <p>{{ $store.state.activeBrewery.phone }}</p>
    <p>{{ $store.state.activeBrewery.email }}</p>
    <a :href="$store.state.activeBrewery.website" target="_blank">
      {{ $store.state.activeBrewery.name }} Homepage</a>
    <p>{{ $store.state.activeBrewery.streetAddress }}</p>
    <p>
      {{ $store.state.activeBrewery.city }},
      {{ $store.state.activeBrewery.state }}
      {{ $store.state.activeBrewery.zip }}
    </p>
    <p>{{ $store.state.activeBrewery.history }}</p>
    <p>
      {{
        $store.state.activeBrewery.hasFood
          ? "Eats and drinks available!"
          : "Sorry, not even peanuts - no food menu."
      }}
    </p>
    
    <tr>
      <th>Day</th>
      <th>Open</th>
      <th>Close</th>
    </tr>
    <tr
    v-for="day in daysOpen"
    v-bind:key="day.dayName"
    class="hours"
    >
    <td>{{day.dayName}}</td>
    <td>{{day.open}}</td>
    <td>{{day.close}}</td>
    </tr>
      <!-- Whoever is doing CSS: may want to set width in css  -->
    <img src="@/resources/dollarSign.png" 
    alt="$"
    v-for="d in getIntegerAvgPrice()"
    v-bind:key="d"
    />

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
    getIntegerAvgPrice(){
      let avgPriceRating = 1;
      let dollarPrice =  this.$store.state.activeBrewery.avgPrice;
        if(dollarPrice >= 5.00 && dollarPrice <= 9.00 ){
          avgPriceRating = 2;
        }else if(dollarPrice>9){
          avgPriceRating = 3;
        }

        return avgPriceRating;
    },
  },
  computed: {
    daysOpen() {
      return this.$store.state.activeBrewery.hours.filter(day => day.open != day.close);
    }
  },
  created() {
    this.getBrewery();
  },
};
</script>

<style scoped>
.breweryLogo {
  width: 15em;
}
img{
  width: 1em;
}
</style>