<template>
  <div class="beer-detail">

  <img class="beerImgBeerDetail" :src="$store.state.activeBeer.imagePath" alt="beerImg" />
    <h2 id="beerName" class="beerDetailItem">{{ $store.state.activeBeer.name }}  </h2>
    <p id="beerType" class="beerDetailItem">Style: {{ $store.state.activeBeer.beerType }}</p>
    <p id="beerDescription" class="beerDetailItem">{{ $store.state.activeBeer.description }}</p>
    <p id="beerAbv" class="beerDetailItem">ABV<br/> {{ $store.state.activeBeer.abv }}</p>
    <p id="beerPrice" class="beerDetailItem">Price<br/> ${{($store.state.activeBeer.price).toFixed(2)}}</p>
    <p id ="beerAverageRating">Average Rating<br/> {{ $store.state.activeBeer.avgScore.toFixed(2)}}</p>
    <button id="activateButton" v-on:click="updateBeer();">{{
        $store.state.activeBeer.active
          ? "Inactivate"
          : "Activate"
      }}</button>
  </div>
</template>

<script>
import BeerService from "../services/BeerService.js";
export default {
  name: "beer",
  methods: {
    getBeer() {
      this.$store.commit("SET_ACTIVE_BEER", this.$route.params.id);
    },
    updateBeer() {
        this.$store.commit("CHANGE_ACTIVE_BEER_STATUS");
        BeerService.updateBeer(this.$store.state.activeBeer)
        .then((response) => {
          if (response.status === 200) {
            this.getBeer();
          } else {
            this.$store.commit("CHANGE_ACTIVE_BEER_STATUS");
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
          " beer. Response received was '" +
          error.response.statusText +
          "'.";
      } else if (error.request) {
        this.errorMsg =
          "Error " + verb + " beer. Server could not be reached.";
      } else {
        this.errorMsg =
          "Error " + verb + " beer. Request could not be created.";
      }
     },
  },
  
  created() {
    this.getBeer();
    // this.beer = this.$store.state.activeBeer;
  }
};

</script>

<style scoped>

#activateButton {
  grid-area: button;
  background-color: #5b965d;
  border-radius: 8px;
  border-style: none;
  box-sizing: border-box;
  color: #FFFFFF;
  cursor: pointer;
  display: inline-block;
  font-size: 14px;
  font-weight: 500;
  height: 40px;
  line-height: 15px;
  list-style: none;
  margin: 0;
  outline: none;
  padding: 10px 16px;
  position: relative;
  text-align: center;
  text-decoration: none;
  transition: color 100ms;
  vertical-align: baseline;
  user-select: none;
  -webkit-user-select: none;
  touch-action: manipulation;
}
#activateButton a{
  text-decoration: none;
}
#activateButton a:visited{
  text-decoration: none;
  color: white;
}


#activateButton:hover,
#activateButton:focus {
  background-color: #a8d4b5;
}

.beer-detail {
padding: 30px 6% 0 6%;
position: relative;
display: grid;
flex-direction: column;
align-items: center;
width: 40%;
margin: auto;
justify-content:center;
text-align: left;
box-sizing: border-box;
grid-template-columns: 1fr 1fr 1fr 1fr;
grid-template-areas:
"image image name name"
"image image type type"
"image image description description"
"abv price rating button";
background-color: rgb(129, 167, 129, .7);
  border-radius: 2em;
  margin-top: 2em;
}

.beerImgBeerDetail {
 width: 11em;
 vertical-align: center;
 border-style: none;
 display: block;
 padding: 10px;
 box-sizing: border-box;
 grid-area: image;
 }

.beerDetailItem {
text-align: left;
grid-area: beerDetailItem;
}

#beerName {
  font-size: 30px;
  justify-self: start;
  box-sizing: border-box;
  grid-area: name;
}

#beerDescription {
  box-sizing: border-box;
  grid-area: description;
}

#beerType {
  grid-area: type;
  font-style: italic;
}

#beerAbv {
  grid-area: abv;
  text-align: center;

}

#beerPrice {
  grid-area: price;
  text-align: center;
}

#beerAverageRating {
  grid-area: rating;
  text-align: center;
}
</style>