import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartView extends StatelessWidget {
  const LineChartView({Key? key}) : super(key: key);

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10,
      color: Colors.purple,
      fontWeight: FontWeight.bold,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 5,
      child: Text(value.toString(), style: style),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        '${value}',
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Color.fromARGB(255, 231, 239, 245),
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: EdgeInsets.only(bottom: 0, top: 15, right: 15, left: 15),
              height: 200,
              width: MediaQuery.of(context).size.height * 1.5,
              child: LineChart(
                LineChartData(
                  maxY: 10,
                  lineTouchData: LineTouchData(enabled: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 0),
                        FlSpot(1, 3),
                        FlSpot(2, 4),
                        FlSpot(3, 5),
                        FlSpot(4, 8),
                        FlSpot(5, 3),
                        FlSpot(6, 5),
                        FlSpot(7, 8),
                        FlSpot(8, 4),
                        FlSpot(9, 7),
                        FlSpot(10, 7),
                        FlSpot(11, 8),
                        FlSpot(12, 0),
                        FlSpot(13, 3),
                        FlSpot(14, 4),
                        FlSpot(15, 5),
                        FlSpot(16, 8),
                        FlSpot(17, 3),
                        FlSpot(18, 5),
                        FlSpot(19, 8),
                        FlSpot(20, 4),
                        FlSpot(21, 7),
                        FlSpot(22, 7),
                        FlSpot(23, 8),
                      ],
                      isCurved: true,
                      barWidth: 2,
                      color: Colors.black,
                      dotData: FlDotData(
                        show: false,
                      ),
                    ),
                  ],
                  minY: 0,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: bottomTitleWidgets,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: leftTitleWidgets,
                        interval: 1,
                        reservedSize: 30,
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 1,
                  ),
                ),
              ),
            )));
  }
}
