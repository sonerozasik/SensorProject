<template>
  <Line
    :chart-options="chartOptions"
    :chart-data="chartData"
    :chart-id="chartId"
    :dataset-id-key="datasetIdKey"
    :plugins="plugins"
    :css-classes="cssClasses"
    :styles="styles"
    :width="width"
    :height="height"
  />
</template>


<script>
  import { Line } from 'vue-chartjs'
  import {
    Chart as ChartJS,
    Title,
    Tooltip,
    Legend,
    LineElement,
    LinearScale,
    PointElement,
    CategoryScale,
    Plugin
  } from 'chart.js'

  ChartJS.register(
    Title,
    Tooltip,
    Legend,
    LineElement,
    LinearScale,
    PointElement,
    CategoryScale
  )
  var yLabels = {
      0: 'OFF',
      1: 'ON'
  }

  export default {
    name: 'TimeLineChart',
    components: { Line },
    props: {
      dates:Array,
      statuses:Array,
      chartId: {
        type: String,
        default: 'line-chart'
      },
      datasetIdKey: {
        type: String,
        default: 'label'
      },
      width: {
        type: Number,
        default: 400
      },
      height: {
        type: Number,
        default: 400
      },
      cssClasses: {
        default: '',
        type: String
      },
      styles: {
        type: Object,
        default: () => {}
      },
      plugins: {
        type: Object,
        default: () => {}
      }
    },
    data() {
      return {
      chartData : {
        labels: [],
        datasets: [
          {
            label: 'ON/OF',
            backgroundColor: 'red',
            borderColor: 'red',
            showLine:true,
            spanGaps:true,
            stepped:true,
            pointRadius:1,
            yAxisID:'onoff'

          }
        ]
      },
      chartOptions : {
        responsive: true,
        maintainAspectRatio: false,
        scales:{
          XAxis:{
            grid:{
              display:false
            }
          },
          onoff :{
            type:'linear',
            position:'left',
            min:0,
            max:1,
            grid:{
              display:false
            },
            ticks:{
              stepSize:1,
              callback: function(value, index, values) {
                return yLabels[value];
              }
            }
          }
        },
        plugins:{
            legend:{
              display:false
            }
          }
        }
      }
    },
    methods:{
      setValues(){
        console.log(this.dates);
        console.log("aaasadasda");
        //todo son değeri göstermiyor
        this.chartData.labels=this.dates;
        this.chartData.datasets[0].data=this.statuses;
      }
    },
    mounted: function () {
      this.setValues();   
    },
    watch:{
      dates:function(_oldV,_newV){
          this.setValues();
        }
    } 
  }
</script>