import Vue from 'vue'
import Router from 'vue-router'
import Home from '../views/Home.vue'
import Login from '../views/Login.vue'
import Logout from '../views/Logout.vue'
import Register from '../views/Register.vue'
import store from '../store/index'
import BrewerHome from '../views/BrewerHome.vue'
import AdminHome from '../views/AdminHome.vue'
import BreweryView from '../views/BreweryView.vue'
<<<<<<< HEAD
<<<<<<< HEAD
import BeerDetailView from '../views/BeerDetailView.vue'
=======
import AdminAddBrewery from '../views/AdminAddBrewery.vue'
import AddReviewView from '../views/AddReviewView.vue'

>>>>>>> 152a72b23bd83fefadff0b89cd4918dc3625b681
=======
import BeerDetailView from '../views/BeerDetailView.vue'
import AdminAddBrewery from '../views/AdminAddBrewery.vue'

>>>>>>> 380519eb759d2c5b22ffbcd7fad2fc6ebd79da42

Vue.use(Router)

/**
 * The Vue Router is used to "direct" the browser to render a specific view component
 * inside of App.vue depending on the URL.
 *
 * It also is used to detect whether or not a route requires the user to have first authenticated.
 * If the user has not yet authenticated (and needs to) they are redirected to /login
 * If they have (or don't need to) they're allowed to go about their way.
 */

const router = new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/login",
      name: "login",
      component: Login,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/logout",
      name: "logout",
      component: Logout,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/register",
      name: "register",
      component: Register,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/beerdetail/:id",
      name: "beerDetail",
      component: BeerDetailView,
      meta:{
        requiresAuth: false
      }
    },
    
    {
      path: "/addreview",
      name: "addReview",
      component: AddReviewView,
      meta:{
        requiresAuth: true
      }
      
    },
    {
      path: "/brewerhome/:id",
      name: "brewerHome",
      component: BrewerHome,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/brewery/:id",
      name: "brewery",
      component: BreweryView,
      meta: {
        requiresAuth: false
      }
    },

    {
      path: "/admin",
      name: "AdminHome",
      component: AdminHome,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/admin/addBrewery",
      name: "AdminAddBrewery",
      component: AdminAddBrewery,
      meta: {
        requiresAuth: false
      }
    }
  ]
})

router.beforeEach((to, from, next) => {
  // Determine if the route requires Authentication
  const requiresAuth = to.matched.some(x => x.meta.requiresAuth);

  // If it does and they are not logged in, send the user to "/login"
  if (requiresAuth && store.state.token === '') {
    next("/login");
  } else {
    // Else let them go to their next destination
    next();
  }
});

export default router;
