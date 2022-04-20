<template>
  <div class="reviews">
    <section
      v-for="review in $store.state.activeReviews"
      v-bind:key="review.reviewId"
      class="review"
    >
      <h2 class="reviewerName">
        {{ review.userName }}
      </h2>
      <hr />
      <div class="stars">
        <p v-for="point in review.score" v-bind:key="point">🍺</p>
      </div>
      <div class="scroll">
        <p class="reviewMessage">
          {{ review.message }}
          <!-- <button @click="showingFullText = !showingFullText"> 
        Read {{ showingFullText ? "Less" : "More" }}
      </button> -->
        </p>
      </div>
    </section>
  </div>
</template>

<script>
import ReviewService from "../services/ReviewService.js";
export default {
  data() {
    return {
      showingFullText: false,
      body: "message",
    };
  },

  name: "review-list",
  methods: {
    getReviews() {
      ReviewService.getReviewList(this.$route.params.id).then((response) => {
        if (response.status === 200) {
          this.$store.commit("SET_ACTIVE_REVIEWS", response.data);
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
          " reviews. Response received was '" +
          error.response.statusText +
          "'.";
      } else if (error.request) {
        this.errorMsg =
          "Error " + verb + " reviews. Server could not be reached.";
      } else {
        this.errorMsg =
          "Error " + verb + " reviews. Request could not be created.";
      }
    },
    formattedMessage(id) {
      let review = this.$store.state.activeReviews.find(
        (review) => review.reviewId == id
      );
      if (this.showingFullText) {
        return review.message;
      } else {
        return String(review.message).slice(0, 20).trim();
      }
    },
  },
  created() {
    this.getReviews();
  },
};
</script>
<style scoped>
.reviews {
  padding: 15px;
  border-radius: 3px;
  display: flex;
  place-items: center;
  margin: auto;
  margin-bottom: 100px;
  justify-content: space-evenly;
  align-items: left;
  flex-wrap: wrap;
  width: 100%;
}

.review {
  width: 25%;
  padding: 20px;
  box-shadow: 2px 2px 30px rgba(0, 0, 0, 0.5);
  padding: 20px;
  margin: 15px;
}
table {
  border-collapse: collapse;
  border-spacing: 0;
  width: 100%;
  border: 0px solid #ddd;
}

th,
td {
  text-align: left;
  padding: 8px;
}

/* width */
::-webkit-scrollbar {
  width: 10px;
}

/* Track */
::-webkit-scrollbar-track {
  background: #f1f1f1;
}

/* Handle */
::-webkit-scrollbar-thumb {
  background: #888;
}

/* Handle on hover */
::-webkit-scrollbar-thumb:hover {
  background: #555;
}

.scroll {
  display: block;
  border: 0px solid red;
  padding: 5px;
  margin-top: 5px;
  width: 100%;
  height: 100px;
  overflow-y: scroll;
}

.stars {
  display: flex;
  font-size: 30px;
  margin-top: -30px;
  margin-bottom: -30px;
}
</style>