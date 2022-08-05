<template>
<div>
  <Doughnut 
      :chart-options="chartOptions"
      :chart-data="chartData"
      :chart-id="chartId"
      :plugins="plugins"
      :css-classes="cssClasses"
      :styles="styles"
      :width="width"
      :height="height"
    />
  </div>
  
</template>


<script>
  import { defineComponent} from 'vue'

  import { Doughnut } from 'vue-chartjs'
  import {
    Chart as ChartJS,
    Title,
    Tooltip,
    Legend,
    ArcElement,
    CategoryScale,
    Plugin
  } from 'chart.js'


  ChartJS.register(Title, Tooltip, Legend, ArcElement, CategoryScale)


  export default defineComponent({
    name: 'DoughnutChart',
    components: {
      Doughnut
    },
    props: {
      batteryValue:Number,
      chartId: {
        type: String,
        default: 'doughnut-chart'
      },
      width: {
        type: Number,
        default: 200
      },
      height: {
        type: Number,
        default: 200
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
        type: Array,
        default: () => []
      }
    },
    data() {
      return {
        chartData : {
          labels: ['Battery'],
          datasets: [
            {
              backgroundColor: ['#41B883', '#FFFFFF'],
              data: [0,0]
            }
          ]
        },
        chartOptions : {
          responsive: true,
          maintainAspectRatio: false,
          plugins:{
            legend: {
                display: false
            }
          }
        }
      }
    },
    methods: {
      setValue(){
        this.chartData.datasets[0].data[0]=this.batteryValue;
        this.chartData.datasets[0].data[1]=100-this.batteryValue;
      }
    },
    watch:{
      batteryValue:function(_oldV,_newV){
        this.setValue();
      }
    },
    mounted: function () {
      this.setValue();   
    }
  })
</script>