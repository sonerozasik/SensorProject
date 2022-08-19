<template>
    <div class="popup">
        <div class="popup-inner">
            <div class="row justify-content-center">
                <h2>Settings</h2>
            </div>
            <div class="row">
                <div style="display:inline-block; float:right;">
                    <select v-model="selectedOptionTime" style="font-size:30px">
                        <option value="byMinute">LastXMinutes</option>
                        <option value="byHour">LastXHours</option>
                        <option value="byDay">LastXDays</option>
                        <option value="byMonth">LastXMonth</option>
                        <option value="between">Between</option>
                    </select>
                    <input v-if="selectedOptionTime!='between'" v-model="xTime" type="numeric" inputmode="numeric" pattern="\d*" style="font-size:25px">
                </div>
            </div>
            <hr>
            <div class="row">
                <div style="display:inline-block; float:right;">
                    <span style="padding-left:30%; font-size:30px;">Device ID : </span>
                    <select v-model="selectedOptionDevice" style="font-size:30px">
                        <option v-for="i in devices" v-bind:value="i">{{i}}</option>
                    </select>
                </div>
            </div>
            <hr>
            <div class="row" v-if="selectedOptionTime=='between'">
                <div style="display:inline-block; float:right;">
                    <span style="font-size:30px;">Start Date : </span>
                    <input type="datetime-local" v-model="this.startDate">
                    <hr>
                    <span style="font-size:30px;">End Date : </span>
                    <input type="datetime-local" v-model="this.endDate">
                    
                </div>
            </div>
            <div class="row p-4">
                <button @click="closePopup(); this.emit();">SAVE</button> 
            </div>
        </div>
    </div>
</template>


<script>
    import axios from 'axios';

    export default{
        props:{
            closePopup:Function,
        },
        data(){
            return{
                xTime:1,
                selectedOptionTime:'byHour',
                selectedOptionDevice:1,
                devices:[],
                startDate:0,
                endDate:0,
            }
        },
        methods:{
            emit(){
                if(this.selectedOptionTime=='between')
                    this.$emit('getOptionValue',{startDate:this.startDate,endDate:this.endDate,optionTime:this.selectedOptionTime,optionDevice:this.selectedOptionDevice});
                else
                    this.$emit('getOptionValue',{value:this.xTime,optionTime:this.selectedOptionTime,optionDevice:this.selectedOptionDevice});
            },
            getDeviceIds(){
                axios.get("https://apimqtt.innovaarge.site/api/Device/getAllIds")
                .then(response=>{
                    this.devices=response.data;
                })
            }
        },
        created(){
            this.getDeviceIds();
        }
    }
</script>

<style lang="scss" scoped>
    .popup{
        position: fixed;
        top:0;
        left:0;
        bottom:0;
        right: 0;
        z-index: 99;
        background-color: rgba(0,0,0,0.2);

        display: flex;
        align-items: center;
        justify-content: center;

        .popup-inner{
            background-color:#FFF ;
            padding: 100px;
            border-radius: 10%;
        }
    }
</style>