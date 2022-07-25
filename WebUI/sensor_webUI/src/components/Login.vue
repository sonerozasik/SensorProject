<template>
  <div class="vue-tempalte">
    <form>
      <h3>Login</h3>

      <div class="form-group">
        <label>UserName</label>
        <input type="username" class="form-control form-control-lg" v-model="usernameText"/>
      </div>

      <div class="form-group">
        <label>Password</label>
        <input type="password" class="form-control form-control-lg" i v-model="passwordText"/>
      </div>

      <button type="submit" class="btn-dark btn-lg btn-block gonder">
        Sign In
      </button>

      <p class="forgot-password text-right">
        Already registered
        <router-link :to="{ name: 'signup' }">sign up?</router-link>
      </p>
      <p class="forgot-password text-right mt-2 mb-4">
        <router-link to="/forgot-password">Forgot password ?</router-link>
      </p>
    </form>
  </div>
</template>

<script>
export default{
    props:["LoginMessage"],
    data(){
        return {
            usernameText: "",
            passwordText: ""
        }
    },
    methods: {
        login(){
            console.log(this.usernameText)
            console.log(this.passwordText)

            //TEST HARDCODE
            if(this.usernameText=="admin" && this.passwordText=="admin"){
                this.$emit('LoginMessage',"Successful");
            }else {
            this.$emit('LoginMessage',"Failed");
            return false;
            }
            
        }

    }
}
</script>
