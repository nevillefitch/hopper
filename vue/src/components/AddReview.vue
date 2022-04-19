<template>
  <div>
    <form v-on:submit.prevent>
      <div class="field">
        <label for="rating">Rating: </label>
        <input type="text" name="rating" id="rating" v-model="review.score" />
      </div>
      <div class="field">
        <label for="message">Review: </label>
        <input
          type="textarea"
          name="message"
          id="message"
          v-model="review.message"
        />
      </div>

      <div class="actions">
        <button type="submit" v-on:click="addReview()">Add Review</button>
      </div>
    </form>
  </div>
</template>

<script>
import ReviewService from "../services/ReviewService.js";

export default {
  name: "create-review",
  data() {
    return {
      review: {
        message: "",
        score: "",
        beerId: "",
        userId: "",
      },
    };
  },

  methods: {
    addReview() {
      ReviewService.createReview(this.review).then((response) => {
        if (response.status === 201) {
          this.$router.push({ name: "beerDetail" });
        }
      });
    },
  },
  created() {
    this.review.beerId = this.$store.state.activeBeer.beerId;
    this.review.userId = this.$store.state.user.id;
  },
};
</script>

<style scoped>
#message {
  width: 15em;
  height: 15em;
}
</style>