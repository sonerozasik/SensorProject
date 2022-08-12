import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sensor_mobile/constants.dart';
import 'package:sensor_mobile/models/post.dart';
import 'package:sensor_mobile/services/remote_service.dart';

class LineChartView extends StatefulWidget {
  const LineChartView({Key? key}) : super(key: key);

  @override
  LineChartViewState createState() => LineChartViewState();
}

class LineChartViewState extends State<LineChartView> {
  final time_frame = TextEditingController(text: "1");
  bool _hasBeenPressed1 = false;
  bool _hasBeenPressed2 = true;
  bool _hasBeenPressed3 = false;
  List<FlSpot>? spots = [const FlSpot(0.0, 0.0)];
  List<FlSpot>? spots2 = [const FlSpot(0.0, 0.0)];
  List<Post>? posts;
  Timer? timer;
  var len = 0;
  var lastheat = 0;
  var lastbattery = 0;

  double minvalue = 3000;
  double maxvalue = -5;

  @override
  void initState() {
    super.initState();
    getData();
    timer =
        Timer.periodic(const Duration(seconds: 30), (Timer t) => {getData()});
  }

  getData() async {
    posts = await RemoteService().getPosts();
    if (posts != null) {
      setState(() {
        len = posts!.length;
        spots!.clear();
        spots2!.clear();
        for (int i = 0; i < len; i++) {
          spots!.add(FlSpot(i.toDouble(), posts![i].pil.toDouble()));
          spots2!.add(FlSpot(i.toDouble(), posts![i].sicaklik.toDouble()));
          if (posts![i].pil.toDouble() > maxvalue) {
            maxvalue = posts![i].pil.toDouble();
          }
          if (posts![i].pil.toDouble() < minvalue) {
            minvalue = posts![i].pil.toDouble();
          }
          if (posts![i].sicaklik.toDouble() > maxvalue) {
            maxvalue = posts![i].pil.toDouble();
          }
          if (posts![i].sicaklik.toDouble() < minvalue) {
            minvalue = posts![i].pil.toDouble();
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
    if (value < 0 || value > len - 1) return Container();
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: (posts != null)
          ? Text(
              posts![(value).toInt()].date.hour.toString() +
                  ":" +
                  posts![(value).toInt()].date.minute.toString() +
                  ":" +
                  posts![(value).toInt()].date.second.toString() +
                  "\n" +
                  posts![(value).toInt()].date.day.toString() +
                  "." +
                  posts![(value).toInt()].date.month.toString() +
                  "." +
                  posts![(value).toInt()].date.year.toString(),
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
        '$value',
        style: style,
      ),
    );
  }

  Widget rightTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 31, 52, 97),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        '$value',
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<FlSpot>? spo = spots;
    List<FlSpot>? spo2 = spots2;

    print(spo);
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: const Color.fromARGB(255, 231, 239, 245),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color.fromARGB(201, 103, 149, 182),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              width: 200,
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  const Text(
                    "Time Frame: ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 0,
                  ),
                  Container(
                    width: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(0, 214, 221, 225),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    height: 40.0,
                    child: TextField(
                      onChanged: (value) {
                        RemoteService.bytime = "byDay";
                        RemoteService.lastxtime = time_frame.text;
                        getData();
                      },
                      controller: time_frame,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(bottom: 5.0),
                        border: InputBorder.none,
                        hintStyle: kHintTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45.0)),
                    child: const Text(
                      'Hour',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    textColor: Colors.white,
                    color: _hasBeenPressed1 ? koyumavi : acikmavi,
                    onPressed: () => {
                          setState(() {
                            _hasBeenPressed1 = true;
                            _hasBeenPressed2 = false;
                            _hasBeenPressed3 = false;
                            RemoteService.bytime = "byHour";
                            RemoteService.lastxtime = time_frame.text;

                            getData();
                          })
                        }),
                const SizedBox(
                  width: 12,
                ),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45.0)),
                    child: const Text(
                      'Day',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    textColor: Colors.white,
                    color: _hasBeenPressed2 ? koyumavi : acikmavi,
                    onPressed: () => {
                          setState(() {
                            _hasBeenPressed1 = false;
                            _hasBeenPressed2 = true;
                            _hasBeenPressed3 = false;
                            RemoteService.bytime = "byDay";
                            RemoteService.lastxtime = time_frame.text;

                            getData();
                          })
                        }),
                const SizedBox(
                  width: 12,
                ),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45.0)),
                    child: const Text(
                      'Month',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    textColor: Colors.white,
                    color: _hasBeenPressed3 ? koyumavi : acikmavi,
                    onPressed: () => {
                          setState(() {
                            _hasBeenPressed1 = false;
                            _hasBeenPressed2 = false;
                            _hasBeenPressed3 = true;
                            RemoteService.bytime = "byMonth";
                            RemoteService.lastxtime = time_frame.text;

                            getData();
                          })
                        }),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: const EdgeInsets.only(
                      bottom: 8, top: 50, right: 15, left: 15),
                  height: 380,
                  width: len * 60,
                  child: LineChart(
                    LineChartData(
                      maxX: len + 0.5,
                      minX: -0.5,
                      maxY: maxvalue + 5,
                      lineTouchData: LineTouchData(enabled: true),
                      lineBarsData: [
                        LineChartBarData(
                          spots: spo,
                          isCurved: true,
                          barWidth: 2,
                          color: const Color.fromARGB(255, 113, 158, 195),
                          dotData: FlDotData(
                            show: true,
                          ),
                        ),
                        LineChartBarData(
                          spots: spo2,
                          isCurved: true,
                          barWidth: 2,
                          color: const Color.fromARGB(255, 253, 135, 0),
                          dotData: FlDotData(
                            show: true,
                          ),
                        ),
                      ],
                      minY: 0,
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
                            interval: 5,
                            reservedSize: 38,
                          ),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: rightTitleWidgets,
                            interval: 5,
                            reservedSize: 38,
                          ),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 5,
                      ),
                    ),
                  ),
                )),
          ],
        ));
  }
}
