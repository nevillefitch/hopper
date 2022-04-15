import axios from 'axios';

export default {

  login(user) {
    return axios.post('/login', user)
  },

  register(user) {
    return axios.post('/register', user)
  },

  getUsers() {
    return axios.get('/admin')
  },

  updateBeerLoverToBrewer(id) {
    return axios.put(`/admin/${id}`)
  }

}
