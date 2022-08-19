<template>
    <div stlye="height:100px; weight:100%;">
        <h1>ALERTS</h1>
        <hr>
        <ul>
            <li v-for="i in alerts" :key="i" >{{i}}</li>
        </ul>
    </div>
</template>

<script>
    export default{
        props:{alerts:Array},
    }
</script>