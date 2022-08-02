<template>
<div class="row p-5 pb-4 justify-content-center">
    <div class="col-lg-3 m-4 mt-0 "> 
        <div class="row grid justify-content-center" style="height:45%;">
           <BatteryChart  :batteryValue="batteryValue" id="battery"></BatteryChart>
        </div>
        <div class="row grid justify-content-center align-items-center mt-5" style="height:45%; font-size:50px;">
            {{lastTemprature}}°C
        </div>
    </div>
    <div class="col-lg-8 p-5 m-4 mt-0 grid">
        <div class="p-2">
            <i @click="popUpVisible=true;" class="fa fa-gear" id="settings-gear"></i>
            <LineChart :batteryValues="batteryValues" :tempratures="tempratures" :dates="dates" id="chart"></LineChart>
        </div>
    </div>

</div>

<div class="row p-5 pt-0 justify-content-center">
    <div class="col-lg-4 m-4 mt-0 grid"> 
    
    </div>
    <div class="col-lg-7 p-5 m-4 mt-0 grid" style="height:33vh;">
        <TimeLine class="mt-5" style="height:50%;"></TimeLine>
    </div>
</div>
            <TableOptions :closePopup="closePopup" v-if="popUpVisible" @getOptionValue="this.xTime=$event.value; this.xTimeOption=$event.option; this.getData();" >
            </TableOptions>        
           <!--<TimeFilter @getOptionValue="this.xTime=$event.value; this.xTimeOption=$event.option; this.getData();" id="timefilter"></TimeFilter>--> 
    
</template>
            


<script>
import axios from 'axios'
import LineChart from '../components/LineChart.vue'
import BatteryChart from '../components/BatteryChart.vue'
import TimeFilter from '@/components/TimeFilter.vue'
import SideBar from '@/components/SideBar.vue'
import TableOptions from '../components/TableOptions.vue'
import TimeLine from '@/components/TimeLine.vue'


export default{
    data(){
        return {
            xTimeOption:'byHour',
            xTime:1,
            arrayLength:0,
            tempratures:[],
            batteryValues:[],
            dates:[],
            batteryValue:0,
            lastTemprature:0,
            popUpVisible:false,
        }
    },
   components: {
    LineChart,
    BatteryChart,
    TimeFilter,
    TimeFilter,
    SideBar,
    SideBar,
    BatteryChart,
    TableOptions,
    TimeLine
},
    methods:{
    getData(){
        console.log("xTime : "+this.xTime);
        console.log("xTimeOption : "+this.xTimeOption);
        axios.get("https://apimqtt.innovaarge.site/api/SensorRecords/"+this.xTimeOption+"/2/"+this.xTime)
            .then(response=>{
                console.log(response)
                this.dates=[]; this.tempratures=[]; this.batteryValues=[];
                this.arrayLength=response.data.length;
                var i=0;
                while(response.data[i]){
                this.dates.push(response.data[i].date);
                this.tempratures.push(response.data[i].sicaklik);
                this.batteryValues.push(response.data[i].pil);
                i++;
                }
                this.batteryValue=this.batteryValues[this.batteryValues.length-1]
                this.lastTemprature=this.tempratures[this.tempratures.length-1]

            })
            .catch(e=>{
                console.log(e);
            })
        },
        closePopup(){
            this.popUpVisible=false;
        }
    },
    beforeCreate: function () {
        window.setInterval(() => {
            this.getData()
        }, 30000)
    },
    created(){
        this.getData();
    },
    /*watch :{
        xDays(val){
            if(val){
            this.xDays=val;
            this.getData();
            }
        }
    }*/
}
</script>


<style>
#battery canvas{
    height: 15vh;
}
#chart{
    position:relative;
    margin: auto;
    width: 90%;
}
#timefilter{
    margin-right: auto;
    margin-left: auto;
    width: 50%;
}
#battery{
    height: 100%;
    padding-top: 10%;
}
#settings-gear{

    margin-left:95%; 
    font-size:36px; 
    margin-top:10px;
    cursor:pointer;
}
#settings-gear:hover{
    color: gray;
}
.left-block{
    background-color: aqua;
    width: 20%;
    float: left;
}
.right-block{
    background-color: aquamarine;
    width: 80%;
    float: right;
}
.right-in-box{
    margin: auto;
    padding-left: 2%;
    padding-right: 2%;
    float:right;
}
.grid{
    background-color: #f0f0f0;
    border-radius: 15px;
}

</style>