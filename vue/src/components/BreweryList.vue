<template>
  <div class="cards">
    <div v-for="brewery in activeBreweries" v-bind:key="brewery.breweryId" class="cards">
      <router-link class="card" tag="a" v-bind:to="{ name: 'brewery', params: { id: brewery.breweryId } }" >
        <div class="card__image">
          <img class="card__image" :src="brewery.logo" alt="brewery logo" />
        </div>
        
        <div class="card__overlay">
          <div class="card__header">
            <!-- <svg class="card__arc" xmlns="http://www.w3.org/2000/svg"><path /></svg>   -->
            <h2 class="card__title">{{ brewery.name }}</h2>
            <p class="price__container"><img class="card__price"  src="@/resources/dollarSign.png" alt="$" v-for="d in getIntegerAvgPrice(brewery.breweryId)" v-bind:key="d"/></p>
            <p class="card__city__state">{{ brewery.city }}, {{ brewery.state }}</p>
          </div>
          <!-- Inside of Card Detail -->
         
          <p class="card__description">{{ brewery.phone }}</p>
          <p class="card__description">{{ brewery.email }}</p>
          
        
        </div>

      </router-link>
    </div>
  </div>
</template>

<script>
import BreweryService from "../services/BreweryService.js";
export default {
  name: "brewery-list",
  methods: {
    getBreweries() {
      BreweryService.getBreweryList()
        .then((response) => {
          this.$store.commit("SET_BREWERIES", response.data);
        })
        .catch((error) => {
          if (error.response) {
            this.errorMsg =
              "Error retrieving breweries. Error: " + error.response.statusText;
          } else if (error.request) {
            this.errorMsg =
              "Error submitting request for breweries. Cannot reach the server.";
          } else {
            this.errorMsg = "Unknown error. Request could not be completed.";
          }
        });
    },
    getIntegerAvgPrice(id){
      let avgPriceRating = 1;
      let activeBrewery = this.$store.state.breweries.find(brewery => brewery.breweryId == id);
      let dollarPrice = activeBrewery.avgPrice;
        if(dollarPrice >= 5.00 && dollarPrice <= 9.00 ){
          avgPriceRating = 2;
        }else if(dollarPrice>9){
          avgPriceRating = 3;
        }

        return avgPriceRating;
    },
  },
  computed: {
    activeBreweries() {
      return this.$store.state.breweries.filter((brewery) => brewery.active);
    },
  },
  created() {
    this.getBreweries();
  },
};
</script>

<style scoped>


.brewery-logo {
  height: 100px;
  display: flex;
  justify-content: center;
}
.breweryLogo {
  width: 10em;
}

* {
  box-sizing: border-box;
}


.cards {
  display: flex;
  flex-wrap: wrap;
  gap: 2em;
  /* justify deleted will space left first */
  justify-content: space-evenly;
  margin: 4rem 2vw;
  padding: 0;
  list-style-type: none;
}



.card {
  /* I don't think we need the border if background is green */
  /* border: 2px solid black; */
  display: flex;
  position: relative;
  display: block;
  height: 300px;
  width: 300px;  
  border-radius: calc(40 * 1px);
  overflow: hidden;
  text-decoration: none;
  background-color: rgb(110, 160, 110);
  justify-content: center;
  
}

.card__image {      
  display:flex;
  width: 100%;
  height: auto;
  justify-content: center;
  align-items: center;
  padding-bottom: 5em;
  padding-top: 1em;
  padding-right: 2em;
  padding-left: 2em;
 

}

.card__price {
  display: flex;
  flex-direction: column;
}


.price__container {
  display: flex;
  flex-direction: row;
}

.card__overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  z-index: 1;      
  border-radius: calc(40 * 1px);    
  background-color:  rgb(223, 217, 217);      
  transform: translateY(100%);
  transition: .2s ease-in-out;
}

.card:hover .card__overlay {
  transform: translateY(0);
}

.card__header {
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

.card__arc {
  width: 80px;
  height: 80px;
  position: absolute;
  bottom: 100%;
  right: 0;      
  z-index: 1;
}

/* .card__arc path {
  fill:  rgb(223, 217, 217);
  d: path("M 40 80 c 22 0 40 -22 40 -40 v 40 Z");
}        */

.card:hover .card__header {
  transform: translateY(0);
}

.card__thumb {
  flex-shrink: 0;
  width: 50px;
  height: 50px;      
  border-radius: 50%;      
}

.card__title {
  font-size: 1em;
  margin: 0 0 .3em;
  color: black;
}

.card__tagline {
  display: block;
  margin: 1em 0;
  font-family: "MockFlowFont";  
  font-size: .8em; 
  color: #D7BDCA;  
}

.card__city__state {
  font-size: .8em;
  color: #797476;
  
}

.card__description {
  padding: 0 1em 1em;
  margin: 0;
  color: grey;
  font-family: "MockFlowFont";   
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 3;
  overflow: hidden;
}    









</style>

<!--
<template>
  <div class="cards">
      <div v-for="brewery in activeBreweries" v-bind:key="brewery.breweryId" class="cards">
        
        <router-link class="card" tag="div" v-bind:to="{name: 'brewery', params:{ id:brewery.breweryId} }">
        <img class="card__image" :src="brewery.logo" alt="brewery logo" />
        <div class="card__overlay">
          <div class="card__header">
            <svg class="card__arc" xmlns="http://www.w3.org/2000/svg"><path /></svg>                     
            <div class="card__header-text">
            <h2 class="card__title">{{ brewery.name }}</h2></div>
            <p class="card__status">{{ brewery.city }}</p>
          </div>
          <p class="card__description">{{ brewery.phone }}</p>
          <p class="card__description">{{ brewery.email }}</p>
        </div>
        </router-link>


    </div>
  </div>
</template>

<script>
import BreweryService from "../services/BreweryService.js";
export default {
  name: "brewery-list",
  methods: {
    getBreweries() {
      BreweryService.getBreweryList()
        .then((response) => {
          this.$store.commit("SET_BREWERIES", response.data);
        })
        .catch((error) => {
          if (error.response) {
            this.errorMsg =
              "Error retrieving breweries. Error: " + error.response.statusText;
          } else if (error.request) {
            this.errorMsg =
              "Error submitting request for breweries. Cannot reach the server.";
          } else {
            this.errorMsg = "Unknown error. Request could not be completed.";
          }
        });
    },
  },
  computed: {
     activeBreweries() {
      return this.$store.state.breweries.filter(brewery => brewery.active);
    },
    
    
  },
  created() {
    this.getBreweries();
  },
};
</script>

<style scoped>


* {
  box-sizing: border-box;
}


.cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  margin: 4rem 5vw;
  padding: 0;
  list-style-type: none;
}

.card {
  position: relative;
  display: block;
  height: 100%;  
  border-radius: calc(40 * 1px);
  overflow: hidden;
  text-decoration: none;
}

.card__image {      
  width: 100%;
  height: auto;
  padding-bottom: 5em;
  padding-top: 1em;
  padding-right: 2em;
  padding-left: 2em;
 

}

.card__overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  z-index: 1;      
  border-radius: calc(40 * 1px);    
  background-color:  rgb(223, 217, 217);      
  transform: translateY(100%);
  transition: .2s ease-in-out;
}

.card:hover .card__overlay {
  transform: translateY(0);
}

.card__header {
  position: relative;
  display: flex;
  align-items: center;
  gap: 2em;
  padding: 1em;
  border-radius: calc(40 * 1px) 0 0 0;    
  background-color: rgb(223, 217, 217);
  transform: translateY(-100%);
  transition: .2s ease-in-out;
}

.card__arc {
  width: 80px;
  height: 80px;
  position: absolute;
  bottom: 100%;
  right: 0;      
  z-index: 1;
}

.card__arc path {
  fill:  rgb(223, 217, 217);
  d: path("M 40 80 c 22 0 40 -22 40 -40 v 40 Z");
}       

.card:hover .card__header {
  transform: translateY(0);
}

.card__thumb {
  flex-shrink: 0;
  width: 50px;
  height: 50px;      
  border-radius: 50%;      
}

.card__title {
  font-size: 1em;
  margin: 0 0 .3em;
  color: black;
}

.card__tagline {
  display: block;
  margin: 1em 0;
  font-family: "MockFlowFont";  
  font-size: .8em; 
  color: #D7BDCA;  
}

.card__status {
  font-size: .8em;
  color: #797476;
}

.card__description {
  padding: 0 2em 2em;
  margin: 0;
  color: grey;
  font-family: "MockFlowFont";   
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 3;
  overflow: hidden;
}    

</style> -->