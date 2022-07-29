<template>
  <div class="vue-tempalte">

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <div class="container">
        <ul class="navbar-nav ms-auto">
          <li class="navbar-nav">
            <router-link v-if="1" class="nav-item nav-link" to="/">Login</router-link>
          </li>
          <li class="navbar-nav">
            <router-link v-if="1" class="nav-item nav-link" to="/signup">Sign up</router-link>
          </li>
          <li class="navbar-nav">
            <ul>
              <li v-if="1" class="bg-secondary menu"><a href="#">Setting</a>
                <div class="setting">
                  <a href="#">Change UsurName</a>
                  <a href="#">Change Password</a>
                  <a href="#">Exit</a>
                </div>
              </li>
            </ul>
          </li>
        </ul>
        <div class="navbar-nav">
          <a v-if="isAuthenticated" @click="goToDashboard()" class="nav-item nav-link active">Dashboard</a>
        </div>
        <div>

        </div>
      </div>
    </nav>



    <!-- Main -->
    <div class="App">

      <router-view></router-view>
    </div>
  </div>

</template>

<script>
import DashboardForm from './components/DashboardForm.vue'
export default {
  data() {
    return {
      side: 'left',
      currentMenu: 'slide',
      isAuthenticated: false
    };
  },
  components: {
    DashboardForm
  },
  methods: {

    goToDashboard() {
      if (this.isAuthenticated) {
        this.$router.push('/dashboard');
      } else {
        this.$router.push('/');
      }

    },
    updateAutenticateStatus(LoginMessage) {
      if (LoginMessage == "Successful") {
        this.isAuthenticated = true;
      }
      this.goToDashboard();
    }
  }
};


</script>

<style>
ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;
  
}

li {
  float: right;

}

li a {
  display: inline-block;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  color: black;

}

li a:hover,
.menu:hover {
  color: blue;
}

li.menu {
  display: inline-block;

}

.setting {
  display: none;
  position: absolute;
  min-width: 170px;
  height: 165px;
  background-color: white;

}

.setting a {
  display: block;
  text-align: left;
}

/* .acilir-menu a:hover {
    color: white;
} */

.menu:hover .setting {
  display: block;
}

.aktif {
  background-color: #1A3680;
  color: black;
}
</style>
