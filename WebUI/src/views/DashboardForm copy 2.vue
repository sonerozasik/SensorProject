<template>
       <div class="row" style="height:55vh; width:100%; display:flex; align-items:center;">
                <div class="col-6" style="width:20%; height:80%; margin:auto; align-items:center;">
                    <div class="col grid" style="height:60%;">
                            <BatteryChart  :batteryValue="batteryValue" id="battery" ></BatteryChart>
                            <!--<h2 style="float:right; margin-top:-40%; margin-right:14vh;">%50</h2>-->
                    </div>
                    <div class="col grid" style="height:30%; margin-top:4vh;">
                        <h1 style="text-align:center;  font-size:50px;"> {{lastTemprature}}°C</h1>
                    </div>
                </div>
                <div class="col-6 grid" style="width:75%; height:80%; margin:auto">
                    <div>
                        <LineChart :batteryValues="batteryValues" :tempratures="tempratures" :dates="dates" id="chart"></LineChart>
                    </div>
                </div>
            </div>
            <div class="row" style="height:40vh; width:100%;"></div>
        
           <!--<TimeFilter @getOptionValue="this.xTime=$event.value; this.xTimeOption=$event.option; this.getData();" id="timefilter"></TimeFilter>--> 
    
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
            xTimeOption:'byHour',
            xTime:1,
            arrayLength:0,
            tempratures:[],
            batteryValues:[],
            dates:[],
            batteryValue:0,
            lastTemprature:0
        }
    },
   components: {
    LineChart,
    BatteryChart,
    TimeFilter,
    TimeFilter,
    SideBar,
    SideBar,
    BatteryChart
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
                this.lastTemprature=this.tempratures[this.arrayLength-1]

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
    width: 90%;
}
#timefilter{
    margin-right: auto;
    margin-left: auto;
    width: 50%;
}
#battery{
    height: 50%;
}
/*.right-box{
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
}*/
#settings-gear{

    margin-left:95%; 
    font-size:36px; 
    margin-top:10px;

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