<template>
  <div class="reviews">
    <div
      v-for="review in $store.state.activeReviews"
      v-bind:key="review.reviewId"
      class="review"
    >
      <h2>{{review.userName}} gave this beer a score of {{ review.score }}.</h2>
      <p>{{ review.message }}</p>
    </div>
  </div>
</template>

<script>
import ReviewService from "../services/ReviewService.js";
export default {
  name: "review-list",
  methods: {
    getReviews() {
      ReviewService.getReviewList(this.$route.params.id).then((response) => {
        this.$store.commit("SET_ACTIVE_REVIEWS", response.data);
      });
    },
  },
  created() {
    this.getReviews();
  },
};
</script>
<style>
</style>