<template>
    <div class="container-fluid">
        <div class="top-row">
        </div>
        <div class="first-row">
            <div class="left-box">
                <div class="left-in-box">
                 <BatteryChart  :batteryValue="batteryValue" id="battery" ></BatteryChart>
                </div>
            </div>
            <div class="left-in-box">
                        <div class="value-box">
                        Last Value : 0
                        </div>
                </div>
            <div class="right-box">  
                <div class="right-in-box">
                <LineChart :batteryValues="batteryValues" :tempratures="tempratures" :dates="dates" id="chart"></LineChart>
                <br> <br>
                </div>    
            </div>
        </div>
        <div class="second-row">
        </div>  
    </div>
            <TimeFilter @getOptionValue="this.xTime=$event.value; this.xTimeOption=$event.option; this.getData();" id="timefilter"></TimeFilter>
    
</template>
            


<script>
import axios from 'axios'
import LineChart from '../components/LineChart.vue'
import BatteryChart from '../components/BatteryChart.vue'
import TimeFilter from '@/components/TimeFilter.vue'
import SideBar from '@/components/SideBar.vue'

export default{
    data(){
        return {
            xTimeOption:'byMinute',
            xTime:1,
            arrayLength:0,
            tempratures:[],
            batteryValues:[],
            dates:[],
            batteryValue:0
        }
    },
   components: {
    LineChart,
    BatteryChart,
    TimeFilter,
    TimeFilter,
    SideBar,
    SideBar
},
    methods:{
        /*getData(){
        axios.get("https://apimqtt.innovaarge.site/api/SensorRecords/getlastnrecord/2/20")
            .then(response=>{
                console.log(response)
                this.dates=[]; this.tempratures=[]; this.batteryValues=[];
                var i =19;               
                while(response.data[i]){
                this.dates.push(response.data[i].date);
                this.tempratures.push(response.data[i].sicaklik);
                this.batteryValues.push(response.data[i].pil);
                i--;
                }
            })
            .catch(e=>{
                console.log(e);
            })
        },
        printValues(){
            console.log(this.dates)
            console.log(this.tempratures)
            console.log(this.batteryValues)

        }*/
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
                this.batteryValue=this.batteryValues[this.arrayLength-1]
            })
            .catch(e=>{
                console.log(e);
            })
        },
        printValues(){
            console.log(this.dates)
            console.log(this.tempratures)
            console.log(this.batteryValues)

        }
    },
    beforeCreate: function () {
        window.setInterval(() => {
            this.getData()
        }, 10000)
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
#chart{
    position:relative;
    margin: auto;
    width: 100%;
}
#timefilter{
    margin-right: auto;
    margin-left: auto;
    width: 50%;
}
#battery{
    margin: auto;
    margin-top: -20%;
    margin-bottom: -20%;
    width: 70%;
}
.right-box{
    background-color: #f0f0f0;
    width: 75%;
    float: right;
    border-radius: 10px;
}
.left-box{
    width: 20%;
    float: left;
    background-color: #f0f0f0;
    border-radius: 10px;
}
.top-row{
    align-items: center;
    margin: auto;
    margin-top: 25px;
}
.first-row{
    width: 75%;
    float:left;
    margin: auto;
    margin-top:25px;
    margin-left: 15%;
}
.left-in-box{
    margin: auto;
    padding: 10px;
}
.right-in-box{
    margin: auto;
    padding-left: 2%;
    padding-right: 2%;

}
.value-box{
    margin: auto;
    background-color: #f0f0f0;
}
#settings-gear{

    margin-left:95%; 
    font-size:36px; 
    margin-top:10px;

}


</style>