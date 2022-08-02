<template>
  <div style="display: flex; justify-content: center; margin: 5rem">
    <DoughnutChart v-bind="doughnutChartProps" />
  </div>
</template>

<script lang='ts'>
import { computed, ref, defineComponent } from "vue";
import { DoughnutChart, useDoughnutChart } from "vue-chart-3";
import { Chart, ChartData, ChartOptions, registerables } from "chart.js";
var plugin = {
  id: "idOfPlugin",
  beforeDraw: function (chart) {
    var width = chart.width,
      height = chart.height,
      ctx = chart.ctx;
    ctx.restore();
    var fontSize = (height / 150).toFixed(2);
    // ctx.font = `${fontSize}em`
    ctx.font = fontSize + "em Inter";
    ctx.fillStyle = "#4771FA";
    ctx.textBaseline = "middle";

    var text = "10%",
      textX = Math.round((width - ctx.measureText(text).width) / 2),
      textY = height / 1.85;

    ctx.fillText(text, textX, textY);
    ctx.save();
  },
};
Chart.register(...registerables, plugin);

export default defineComponent({
  name: "Home",
  components: { DoughnutChart },
  setup(props) {
    const isResponsive = ref(true);
    const getData = computed<ChartData<"doughnut">>(() => ({
      labels: ["Success"],
      datasets: [
        {
          data: [20, 80],
          backgroundColor: ["#4771FA", "#f0f7ff"],
        },
      ],
    }));
    const options = computed<ChartOptions<"doughnut">>(() => ({
      maintainAspectRatio: false,
      // this controls whether or not it's a doughnut or not
      cutout: 70,
      plugins: {
        legend: {
          position: "top",
          labels: {
            font: {
              family: "Roboto Mono",
            },
            boxWidth: 10,
            boxHeight: 10,
          },
        },
        tooltip: { enabled: false },
        // 'center-text': centerText,
      },
      hover: { mode: null },
      // events: ['mouseout', 'touchstart', 'touchmove', 'touchend'],
      // events:[
      //   hover: {
      //     mode: null,
      //   },
      // ],
      layout: {
        padding: {
          top: 12,
          bottom: 16,
          left: 20,
          right: 20,
        },
      },
      // tooltip: {
      //     bodyFont: {
      //         size: responsiveFontsize.value,
      //         family: 'Roboto Mono'
      //     },
      //     bodyColor: 'green'
      // },
    }));
    const { doughnutChartProps } = useDoughnutChart({
      options,
      chartData: getData,
    });
    return {
      isResponsive,
      getData,
      // options,
      doughnutChartProps,
    };
  },
});
</script>