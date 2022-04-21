<template>
  <div class="outer">
    <div class="beer-detail">
      <img
        class="beerImgBeerDetail"
        :src="$store.state.activeBeer.imagePath"
        alt="beerImg"
      />
      <h2 id="beerName" class="beerDetailItem">
        {{ $store.state.activeBeer.name }}
      </h2>
      <p id="beerType" class="beerDetailItem">
        Style: {{ $store.state.activeBeer.beerType }}
      </p>
      <p id="beerDescription" class="beerDetailItem">
        {{ $store.state.activeBeer.description }}
      </p>
      <p id="beerAbv" class="beerDetailItem">
        ABV<br />
        {{ $store.state.activeBeer.abv }}
      </p>
      <p id="beerPrice" class="beerDetailItem">
        Price<br />
        ${{ $store.state.activeBeer.price.toFixed(2) }}
      </p>
      <p id="beerAverageRating">
        Average Rating<br />
        {{ $store.state.activeBeer.avgScore.toFixed(2) }}
      </p>

      <button id="writeReviewButton">
        <router-link
          :to="{
            name: 'addReview',
            params: { id: $store.state.activeBeer.beerId },
          }"
          >Add Review</router-link
        >
      </button>
      <p id="beerActiveStatus" class="beerDetailItem">
        {{
          $store.state.activeBeer.active
            ? ""
            : "This beer is currently unavailable. Please check back soon!"
        }}
      </p>
    </div>
  </div>
</template>

<script>
import BeerService from "../services/BeerService.js";
export default {
  name: "beer",
  methods: {
    getBeer() {
      BeerService.getBeerById(this.$route.params.id)
        .then((response) => {
          this.$store.commit("SET_UPDATED_ACTIVE_BEER", response.data);
        })
        .catch((error) => {
          this.handleErrorResponse(error, "retrieving");
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
        this.errorMsg = "Error " + verb + " beer. Server could not be reached.";
      } else {
        this.errorMsg =
          "Error " + verb + " beer. Request could not be created.";
      }
    },
  },
  created() {
    this.getBeer();
  },
};
</script>

<style scoped>
#writeReviewButton {
  grid-area: button;
  background-color: #5b965d;
  border-radius: 8px;
  border-style: none;
  box-sizing: border-box;
  color: #ffffff;
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
#writeReviewButton a {
  text-decoration: none;
}
#writeReviewButton a:visited {
  text-decoration: none;
  color: white;
}

#writeReviewButton:hover,
#writeReviewButton:focus {
  background-color: #a8d4b5;
}
/* #writeReviewButton {
 grid-area: button;
 background-color: #5eb161;
  border: none;
  color: white;
  padding: 15px 20px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
} */

.beer-detail {
  padding: 0px 3% 0 3%;
  position: relative;
  display: grid;
  flex-direction: column;
  align-items: center;
  width: 35%;
  margin: auto;
  justify-content: center;
  text-align: left;
  box-sizing: border-box;
  grid-template-columns: 1fr 1fr 1fr 1fr;
  grid-template-areas:
    "image image name name"
    "image image type type"
    "image image description description"
    "abv price rating button"
    "inactive inactive inactive inactive";
  background-color: rgb(129, 167, 129, 0.7);
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
  font-size: 55px;
  justify-self: start;
  box-sizing: border-box;
  grid-area: name;
}

#beerActiveStatus {
  grid-area: inactive;
  text-align: center;
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
}

#beerPrice {
  grid-area: price;
}

#beerAverageRating {
  grid-area: rating;
}
</style>