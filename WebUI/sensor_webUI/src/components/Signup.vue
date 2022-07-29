<template>
  <div class="vue-tempalte">
    <div class="vertical-center">
        <div class="inner-block">
          
      
    <form>
      <h3>Sign Up</h3>

      <div class="form-group">
        <label>UserName</label>
        <input type="text" class="form-control form-control-lg" />
      </div>

      <div class="form-group">
        <label>Email address</label>
        <input type="email" class="form-control form-control-lg" />
      </div>

      <div class="form-group">
        <label>Password</label>
        <input type="password" class="form-control form-control-lg" />
      </div>
<br>
      <button type="submit" class=" btn-dark btn-lg btn-block gonder">
        Sign Up
      </button>

      <p class="forgot-password text-right">
        Already registered
        <router-link :to="{ name: 'login' }">sign in?</router-link>
      </p>
    </form>
  </div>  </div>
      </div>
</template>

<script>
export default {
  data() {
    return {};
  },
};
</script>
