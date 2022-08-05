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
        <div class="col-lg-4 m-4 mt-0 grid" style="height:33vh;"> 
            <AlertBox :alerts="alerts"></AlertBox>
        </div>
        <div class="col-lg-7 p-5 m-4 mt-0 grid" style="height:33vh;">
            <TimeLine :statuses="statuses" :dates="dates2" class="mt-5" style="height:50%;"></TimeLine>
        </div>
    </div>
    <TableOptions :closePopup="closePopup" v-if="popUpVisible" @getOptionValue="this.getEmit($event)" >
    </TableOptions>        
</template>
            


<script>
    import axios from 'axios'
    import LineChart from '../components/LineChart.vue'
    import BatteryChart from '../components/BatteryChart.vue'
    import TimeFilter from '@/components/TimeFilter.vue'
    import SideBar from '@/components/SideBar.vue'
    import TableOptions from '../components/TableOptions.vue'
    import TimeLine from '@/components/TimeLine.vue'
    import AlertBox from '../components/AlertBox.vue'


    export default{
        data(){
            return {
                xTimeOption:'byHour',
                xTime:1,
                deviceOption:1,
                arrayLength:0,
                tempratures:[],
                statuses:[],
                batteryValues:[],
                dates:[], dates2:[],
                alerts:[],
                batteryValue:0,
                lastTemprature:0,
                popUpVisible:false,
                startDate:0,
                endDate:0
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
            TimeLine,
            AlertBox
        },
        methods:{
            getRecordsData(){
                var request;
                if(this.xTimeOption=='between')
                    request=axios.put("https://apimqtt.innovaarge.site/api/SensorRecords/between",{cihazId :this.deviceOption,startDate:this.startDate,endDate:this.endDate});
                else 
                    request=axios.get("https://apimqtt.innovaarge.site/api/SensorRecords/"+this.xTimeOption+"/"+this.deviceOption+"/"+this.xTime);
                request
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
                    ///////
                    this.getStatusesData();
                })
                .catch(e=>{
                    console.log(e);
                })
            },
            getStatusesData(){
            var request;
            if(this.xTimeOption=='between')
                request=axios.put("https://apimqtt.innovaarge.site/api/DeviceStatus/between",{cihazId :this.deviceOption,startDate:this.startDate,endDate:this.endDate});
            else 
                request=axios.get("https://apimqtt.innovaarge.site/api/DeviceStatus/"+this.xTimeOption+"/"+this.deviceOption+"/"+this.xTime);
            request
                .then(response2=>{
                    console.log(response2)
                    this.dates2=[]; this.statuses=[];
                    var i=0;
                    while(response2.data[i]){
                        this.dates2.push(response2.data[i].date);
                        if(response2.data[i].isActive)
                            this.statuses.push(1);
                        else 
                            this.statuses.push(0);
                        i++;
                    }
                    this.getAlerts();
                })
                .catch(e=>{
                    console.log(e);
                })

            },
            getAlerts(){
                axios.get("https://apimqtt.innovaarge.site/api/Alerts/getLastXAlert/10")
                .then(response=>{
                    console.log("Alerts:");
                    console.log(response);
                    this.alerts=[];
                    var i=response.data.length-1;
                        while(response.data[i]){
                            this.alerts.push(response.data[i].message+" ("+response.data[i].date+")");
                            i--;
                        }
                })
                .catch(e=>{
                    console.log(e);
                })
            },
            getEmit(event){
                this.xTimeOption=event.optionTime;
                this.deviceOption=event.optionDevice; 
                if(this.xTimeOption=='between'){
                    this.startDate=event.startDate;
                    this.endDate=event.endDate;
                }
                else
                    this.xTime=event.value; 
                
                this.getRecordsData();
            },
            closePopup(){
                this.popUpVisible=false;
            }, 
        },
        beforeCreate: function () {
            window.setInterval(() => {
                this.getRecordsData()
            }, 30000)
        },
        created(){
            this.getRecordsData();
        }
        
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
    .grid{
        background-color: #f0f0f0;
        border-radius: 15px;
    }
</style>