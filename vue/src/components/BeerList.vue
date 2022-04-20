<template>
  <div class="beer__cards">
    <div
      v-for="beer in activeBeerList"
      v-bind:key="beer.beerId"
      class="beer__cards"
    >
      <!-- when brewer logged in -->
      <router-link
        class="beer__card"
        v-if="isLoggedInBrewersBrewery"
        v-bind:to="{ name: 'brewerBeer', params: { id: beer.beerId } }"
      >
      <div class="beer__card__image">
        <img class="beer__card__image" :src="beer.imagePath" alt="beerImg" />
      </div>

      <div class="beer__card__overlay">
        <div class="beer__card__header">
          <h2 class="beer__card__title">{{ beer.name }}</h2>
          <p class="beer__card__sub__title">{{ beer.beerType }}</p>
        </div>
        <p class="beer__card__description">Score: {{ parseFloat(beer.avgScore).toFixed(2) }} &nbsp;|&nbsp;  ABV: {{ beer.abv }}  &nbsp;|&nbsp;  Price: ${{ beer.price }}</p>
      </div>
      </router-link>

      <!-- when brewer not the user -->
      <router-link
        class="beer__card"
        v-if="!isLoggedInBrewersBrewery"
        v-bind:to="{ name: 'beerDetail', params: { id: beer.beerId } }"
      >
        <div class="beer__card__image">
          <img class="beer__card__image" :src="beer.imagePath" alt="beerImg" />
        </div>
        <div class="beer__card__overlay">
          <div class="beer__card__header">
            <h2 class="beer__card__title">{{ beer.name }}</h2>
            <p class="beer__card__sub__title">{{ beer.beerType }}</p>
          </div>
          <p class="beer__card__description">Score: {{ parseFloat(beer.avgScore).toFixed(2) }} &nbsp;|&nbsp;  ABV: {{ beer.abv }}  &nbsp;|&nbsp;  Price: ${{ beer.price }}</p>
      </div>
      </router-link>
    </div>
  </div>
</template>

<script>
import BeerService from "../services/BeerService.js";
export default {
  name: "beer-list",
  methods: {
    getBeers() {
      BeerService.getBeers(this.$route.params.id).then((response) => {
        if (response.status === 200) {
            this.$store.commit("SET_ACTIVE_BEERS", response.data);
        }
      })
      .catch((error) => {
          this.handleErrorResponse(error, "retrieving")
        })
    },
    handleErrorResponse(error, verb) {
      if (error.response) {
        this.errorMsg =
          "Error " +
          verb +
          " beers. Response received was '" +
          error.response.statusText +
          "'.";
      } else if (error.request) {
        this.errorMsg =
          "Error " + verb + " beers. Server could not be reached.";
      } else {
        this.errorMsg =
          "Error " + verb + " beers. Request could not be created.";
      }
    },
  },
  created() {
    this.getBeers();
  },
  computed: {
    isLoggedInBrewersBrewery() {
      return (
        this.$store.state.activeBrewery.ownerId == this.$store.state.user.id
      );
    },
    activeBeerList() {
       return this.$store.state.activeBeers.filter((beer) => beer.active);
    }
  },
};
</script>

<style scoped>



.beer__cards {
  display: flex;
  flex-wrap: wrap;
  gap: 2em;
  /* justify deleted will space left first */
  justify-content: space-evenly;
  margin: 4rem 2vw;
  padding: 0;
  list-style-type: none;
}

/* .card__image:hover {
  background-color: rgb(182, 216, 182);
} */


.beer__card {
  display: flex;
  position: relative;
  display: block;
  height: 200px;
  width: 200px;  
  border-radius: calc(40 * 1px);
  overflow: hidden;
  text-decoration: none;
  background-color: rgb(110, 160, 110);
  justify-content: center;
  
  
}

.beer__card__image {      
  display:flex;
  width: 75%;
  height: auto;
  justify-content: center;
  align-items: center;
  padding-bottom: 5em;
  padding-right: 2em;
  padding-left: 2em;
 

}

.beer__card__price {
  display: flex;
  flex-direction: column;
}


.beer__price__container {
  display: flex;
  flex-direction: row;
}

.beer__card__overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  z-index: 1;      
  border-radius: calc(40 * 1px);    
  background-color:  rgb(223, 217, 217);      
  transform: translateY(100%);
  transition: .2s ease-in-out;
  text-align: center;
}

.beer__card:hover .beer__card__overlay {
  transform: translateY(0);
  
}

.beer__card__header {
  position: relative;
  
  display: flex;
  align-items: center;
  gap: 1em;
  padding: 1em;
  border-top-left-radius: 40px;
  border-top-right-radius: 40px;
  background-color: rgb(223, 217, 217);
  transform: translateY(-100%);
  transition: .2s ease-in-out;
}

.beer__card__arc {
  width: 80px;
  height: 80px;
  position: absolute;
  bottom: 100%;
  right: 0;      
  z-index: 1;
}



.beer__card:hover .beer__card__header {
  transform: translateY(0);
}

.beer__card__thumb {
  flex-shrink: 0;
  width: 50px;
  height: 50px;      
  border-radius: 50%;      
}

.beer__card__title {
  font-size: 1em;
  margin: 0 0 .3em;
  color: black;
}

.beer__card__tagline {
  display: block;
  margin: 1em 0;
  /* font-family: "MockFlowFont";   */
  font-size: .8em; 
  color: #D7BDCA;  
}

.beer__card__city__state {
  font-size: .8em;
  color: #797476;
  
}

.beer__card__description {

  padding-bottom: 3em;
  margin: 0;
  color: rgb(70, 68, 68);
  /* font-family: "MockFlowFont";   */
  font-size: .80em; 
  display: flex;
  justify-content: center;
  overflow: hidden;

}    

.beer__card__sub__title {
  font-size: .8em;
  color: #797476;

}


</style>