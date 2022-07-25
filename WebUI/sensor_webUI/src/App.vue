<template>
  <div class="vue-tempalte">
    <!-- Navigation -->
    <nav class="navbar shadow bg-white rounded justify-content-between flex-nowrap flex-row fixed-top">
      <div class="container">
        <ul class="nav navbar-nav flex-row float-right">
          <li class="nav-item">
            <router-link class="nav-link pr-3" to="/">Login</router-link>
          </li>
          <li class="nav-item">
            <router-link class="btn btn-outline-primary" to="/signup">Sign up</router-link>
          </li>
        </ul>
      </div>
    </nav>
    <div class="navbar-nav">
                <a href="#" class="nav-item nav-link active">Home</a>
                <a v-if="isAuthenticated" @click="goToDashboard()" class="nav-item nav-link active">Dashboard</a>
            </div>
    

    <!-- Main -->
    <div class="App">
      <div class="vertical-center">
        <div class="inner-block">
          <router-view></router-view>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import DashboardForm from './components/DashboardForm.vue'

export default{
  components: {
    DashboardForm
},
  data(){
    return{
        isAuthenticated : false
    }
  },
  methods : {
   goToDashboard(){
    if(this.isAuthenticated){
        this.$router.push('/dashboard');
    }else{
        this.$router.push('/');
    }
    
   },
   updateAutenticateStatus(LoginMessage){
    if(LoginMessage=="Successful"){
        this.isAuthenticated=true;
    }
    this.goToDashboard();
   }

  }
}
</script>