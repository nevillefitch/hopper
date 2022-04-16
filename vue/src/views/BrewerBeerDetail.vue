<template>
  <div>
    <brewer-beer-detail/>
    <review-list/>
  </div>
</template>

<script>
import BrewerBeerDetail from "../components/BrewerBeerDetail.vue";
import ReviewList from "../components/ReviewList.vue";
export default {
components: { BrewerBeerDetail, ReviewList },
}
</script>

<style>

</style>