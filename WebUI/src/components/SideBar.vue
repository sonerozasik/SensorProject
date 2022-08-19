<template>
  <ul class="sidebar nav navbar-nav side-nav bg-light">
    <router-link to="/dashboard" class="menu-item">Dashboard</router-link>
    <router-link to="/settings" class="menu-item">Settings</router-link>
    <router-link to="/adddevice" class="menu-item">Add Device</router-link>
    <router-link to="/deletedevice" class="menu-item">Delete Device</router-link>
    <router-link @click="logout()" to="/" class="menu-item">Log Out</router-link>
  </ul>
</template>

<script>
  export default{
    props:{
      logout: Function
    }
  }

</script>

<style>
  .sidebar{
    font-size: large;
    background-color:  #f0f0f0;
    height:100%; 
  }
  .menu-item{
    height: 50px;
    display: flex;
    justify-content: center;
    align-items: center;
    color: rgb(60, 60, 60);
    text-decoration: none;
  }
  .menu-item:hover{
    background-color: #c9c9c9;

  }
  .menu-item:active{
    background-color: #666666;

  }
  li { cursor: pointer; }
</style>