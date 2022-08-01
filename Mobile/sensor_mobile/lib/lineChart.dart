import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sensor_mobile/dashboard_grid.dart';
import 'package:sensor_mobile/models/post.dart';
import 'package:sensor_mobile/services/remote_service.dart';

class LineChartView extends StatefulWidget {
  const LineChartView({Key? key}) : super(key: key);

  @override
  _LineChartViewState createState() => _LineChartViewState();
}

class _LineChartViewState extends State<LineChartView> {
  List<FlSpot>? spots = [FlSpot(0.0, 0.0)];
  List<Post>? posts;
  Timer? timer;
  var len = 0;

  double minvalue = 3000;
  double maxvalue = -5;
  void initState() {
    super.initState();
    // timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => getData());
    getData();
  }

  getData() async {
    posts = await RemoteService().getPosts();
    if (posts != null) {
      setState(() {
        len = posts!.length;
        spots!.clear();
        for (int i = 0; i < 50; i++) {
          spots!.add(FlSpot(i.toDouble(), posts![len - 50 + i].pil.toDouble()));
          if (posts![len - i - 1].pil.toDouble() > maxvalue) {
            maxvalue = posts![len - i - 1].pil.toDouble();
          }
          if (posts![len - i - 1].pil.toDouble() < minvalue) {
            minvalue = posts![len - i - 1].pil.toDouble();
          }
        }
      });
    }
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10,
      color: Color.fromARGB(255, 31, 52, 97),
      fontWeight: FontWeight.bold,
    );
    if (value < 0 || value > 49) return Container();
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: (posts != null)
          ? Text(
              posts![(len - 50 + value).toInt()].date.hour.toString() +
                  ":" +
                  posts![(len - 50 + value).toInt()].date.minute.toString() +
                  ":" +
                  posts![(len - 50 + value).toInt()].date.second.toString() +
                  "\n" +
                  posts![(len - 50 + value).toInt()].date.day.toString() +
                  "." +
                  posts![(len - 50 + value).toInt()].date.month.toString() +
                  "." +
                  posts![(len - 50 + value).toInt()].date.year.toString(),
              textAlign: TextAlign.center,
              style: style,
            )
          : const SizedBox(
              child: CircularProgressIndicator(
                strokeWidth: 0.5,
              ),
              height: 10.0,
              width: 10.0,
            ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 31, 52, 97),
    );

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
    List<FlSpot>? spo = spots;

    print(spo);
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Color.fromARGB(255, 231, 239, 245),
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: EdgeInsets.only(bottom: 8, top: 15, right: 15, left: 15),
              height: 300,
              width: MediaQuery.of(context).size.height * 4,
              child: LineChart(
                LineChartData(
                  maxX: 49.5,
                  minX: -0.5,
                  maxY: maxvalue + 5,
                  lineTouchData: LineTouchData(enabled: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spo,
                      isCurved: true,
                      barWidth: 2,
                      color: Color.fromARGB(255, 113, 158, 195),
                      dotData: FlDotData(
                        show: true,
                      ),
                    ),
                  ],
                  minY: minvalue - 5,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        reservedSize: 27,
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: bottomTitleWidgets,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: leftTitleWidgets,
                        interval: 3,
                        reservedSize: 38,
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
                    horizontalInterval: 3,
                  ),
                ),
              ),
            )));
  }
}
