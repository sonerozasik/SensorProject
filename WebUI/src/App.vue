<template>
<div class="container-fluid">
    <div class="row">
        <NavBar :username="username" :isAuthenticated="isAuthenticated"></NavBar>
    </div>
    <div class="row">
        <div class="col-lg-2 px-0" style="background-color:black;" v-if="isAuthenticated">
            <SideBar></SideBar>
        </div>
        <div class="col">
            <RouterView :username="username" 
            v-on:changePasswordResponse="changePasswordResponse($event)" 
            v-on:changeUsernameResponse="changeUsernameResponse($event)" 
            v-on:signupResponse="signupResponse($event)" 
            v-on:loginResponse="loginResponse($event)">
            </RouterView> 
        </div>
    
    </div>
</div>
<!--<NavBar :username="username" :isAuthenticated="isAuthenticated"></NavBar>
<SideBar></SideBar>
<RouterView :username="username" 
v-on:changePasswordResponse="changePasswordResponse($event)" 
v-on:changeUsernameResponse="changeUsernameResponse($event)" 
v-on:signupResponse="signupResponse($event)" 
v-on:loginResponse="loginResponse($event)">
</RouterView>-->
 
</template>

<script>
import Swal from 'sweetalert2'
import SideBar from './components/SideBar.vue';
import NavBar from './views/NavBar.vue';
export default{
    data() {
        return {
            isAuthenticated: false,
            username: ""
        };
    },
    methods: {
        loginResponse(response) {
            if (response.succes == true) {
                this.isAuthenticated = true;
                this.username = response.username;
                this.succesMessage(response.message);
                this.$router.push("/dashboard");
            }
            else {
                this.errorMessage(response.message);
            }
        },
        signupResponse(response) {
            if (response.succes == true) {
                this.$router.push("/");
                this.succesMessage(response.message);
            }
            else {
                this.errorMessage(response.message);
            }
        },
        changeUsernameResponse(response) {
            if (response.succes == true) {
                this.$router.push("/dashboard");
                this.succesMessage(response.message);
                this.username = response.username;
            }
            else {
                this.errorMessage(response.message);
            }
        },
        changePasswordResponse(response) {
            if (response.succes == true) {
                this.$router.push("/dashboard");
                this.succesMessage(response.message);
            }
            else {
                this.errorMessage(response.message);
            }
        },
        errorMessage(messageText) {
            Swal.fire({
                icon: "error",
                title: "Oops...",
                text: messageText,
            });
        },
        succesMessage(messageText) {
            Swal.fire({
                position: "top",
                icon: "success",
                title: messageText,
                showConfirmButton: false,
                timer: 1500
            });
        }
    },
    components: { SideBar, NavBar, NavBar, SideBar }
}
</script>

<style>
html{
    height: 100%;
}
body {
    background: #dbdbdb;
    font-family: 'Roboto', sans-serif;
    height: 100%;
}


</style>
