<template>
    <nav id="navbar" class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <a href="#" class="navbar-brand">INNOVA</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <div class="navbar-nav ms-auto">
                    <router-link to="/" v-if="!isAuthenticated" class="nav-item nav-link">LOGIN</router-link>
                    <router-link to="/signup" v-if="!isAuthenticated" class="nav-item nav-link">SIGN UP</router-link>
                    <router-link to="/dashboard" v-if="isAuthenticated" class="nav-item nav-link">{{ username }}</router-link>
                </div>
            </div>
        </div>
    </nav>
</template>


<script>
    export default{
        props:{
            isAuthenticated:Number,
            username:String
        }
    }
</script>

<style>
    #navbar{
        background-color: #475c6c;
    }
</style>