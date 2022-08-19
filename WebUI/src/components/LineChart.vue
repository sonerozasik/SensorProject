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

  export default {
    name: 'LineChart',
    components: { Line },
    props: {
      dates:Array,
      batteryValues:Array,
      tempratures:Array,
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
            label: 'Temprature',
            backgroundColor: '#6060eb',
            borderColor: '#6060eb',
            //data: [],
            showLine:true,
            spanGaps:true,
            pointRadius:1,
            
          },
          {
            label: 'Battery',
            backgroundColor: '#41B883',
            borderColor: '#41B883',
            pointRadius:1,
            //data: [,,,,,,,,,],
            showLine:true,
            spanGaps:true
          }
        ]
      },
        chartOptions : {
        responsive: true,
        maintainAspectRatio: false
      },

      }
    },
      mounted: function () {
        this.setValues();   
      },
      methods:{
        setValues(){
          this.chartData.labels=this.dates;
          this.chartData.datasets[0].data=this.tempratures;
          this.chartData.datasets[1].data=this.batteryValues;
        }
      },
      watch:{
        dates:function(_oldV,_newV){
          this.setValues();
        }
      }
    }
</script>