import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sensor_mobile/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:sensor_mobile/models/post.dart';
import 'package:sensor_mobile/services/remote_service.dart';

class StatsGrid extends StatefulWidget {
  @override
  StatsGridState createState() => StatsGridState();
}

class StatsGridState extends State<StatsGrid> {
  final devicecontroller = TextEditingController(text: "2");
  final time_frame = TextEditingController(text: "3");
  bool _hasBeenPressed1 = false;
  bool _hasBeenPressed2 = true;
  bool _hasBeenPressed3 = false;
  final List<BatteryData> chartData = [
    BatteryData("2", 35, 2),
  ];
  List<Post>? posts;
  var len = 0;
  var lastheat = 0;
  late bool isPointerMoved;
  var lastbattery = 0;
  List<FlSpot>? spots = [const FlSpot(0.0, 0.0)];
  double minvalue = 3000;
  double maxvalue = -5;
  @override
  void initState() {
    super.initState();
    getdata1();
  }

  getdata1() async {
    chartData.clear();
    posts = await RemoteService().getPosts();
    print("POSTS");
    if (posts != null) {
      setState(() {
        len = posts!.length;
        lastheat = posts![len - 1].sicaklik;
        lastbattery = posts![len - 1].pil;

        for (int i = 0; i < len; i++) {
          print(posts![i].date);

          String zaman = posts![i].date.day.toString() +
              "." +
              posts![i].date.month.toString() +
              "." +
              posts![i]
                  .date
                  .year
                  .toString()
                  .substring(posts![i].date.year.toString().length - 2) +
              " - " +
              posts![i].date.hour.toString() +
              ":" +
              posts![i].date.minute.toString();
          chartData.add(BatteryData(
              zaman, posts![i].pil.toDouble(), posts![i].sicaklik.toInt()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 860,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color.fromARGB(201, 103, 149, 182),
              borderRadius: BorderRadius.all(Radius.circular(
                      20.0) //                 <--- border radius here
                  ),
            ),
            width: 200,
            child: Row(
              children: [
                const SizedBox(width: 20),
                const Text(
                  "Device: ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 0,
                ),
                Container(
                  width: 80,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(0, 214, 221, 225),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  height: 40.0,
                  child: TextFormField(
                    onChanged: (value) {
                      RemoteService.deviceid = value;
                      getdata1();
                    },
                    controller: devicecontroller,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: "0 to 3",
                      contentPadding: const EdgeInsets.only(bottom: 5.0),
                      border: InputBorder.none,
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.6)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              _buildStatCard('Last Heat Value', lastheat.toString() + "°",
                  const Color.fromARGB(255, 115, 148, 170)),
              _buildStatCard(
                'Battery Life',
                lastbattery.toString() + '%',
                const Color.fromARGB(255, 63, 139, 158),
              ),
            ],
          ),
          TimeFrame(),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Linechart(context),
          )
        ],
      ),
    );
  }

  Card TimeFrame() {
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
                      onEditingComplete: () {
                        RemoteService.lastxtime = time_frame.text;
                        getdata1();
                      },
                      onChanged: (value) {
                        RemoteService.lastxtime = value;
                        getdata1();
                      },
                      onSubmitted: (value) {
                        RemoteService.lastxtime = value;
                        getdata1();
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

                            getdata1();
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

                            getdata1();
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

                            getdata1();
                          })
                        }),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ],
        ));
  }

  Container Linechart(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        child: SfCartesianChart(
            zoomPanBehavior: ZoomPanBehavior(
                enablePinching: true,
                zoomMode: ZoomMode.x,
                enablePanning: true,
                enableMouseWheelZooming: true),
            onChartTouchInteractionMove: (ChartTouchInteractionArgs args) {
              isPointerMoved = true;
            },
            onChartTouchInteractionUp: (ChartTouchInteractionArgs args) {
              isPointerMoved = false;
            },
            borderWidth: 1,
            borderColor: koyumavi,
            tooltipBehavior: TooltipBehavior(
                canShowMarker: true,
                elevation: 10,
                enable: true,
                borderWidth: 1,
                borderColor: koyumavi,
                color: Colors.white,
                textStyle: TextStyle(color: koyumavi)),
            plotAreaBorderWidth: 0,
            legend: Legend(
                borderColor: koyumavi,
                backgroundColor: Color.fromARGB(255, 245, 245, 245),
                borderWidth: 2,
                toggleSeriesVisibility: true,
                position: LegendPosition.bottom,
                isResponsive: false,
                overflowMode: LegendItemOverflowMode.none,
                isVisible: true),
            primaryXAxis: CategoryAxis(
                labelRotation: 90,
                labelIntersectAction: AxisLabelIntersectAction.trim,
                maximumLabels: 100,
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                autoScrollingDelta: 5,
                autoScrollingMode: AutoScrollingMode.end,
                labelPlacement: LabelPlacement.onTicks,
                minimum: -0.5,
                maximum: len.toDouble() - 0.5),
            primaryYAxis: NumericAxis(
                anchorRangeToVisiblePoints: true,
                labelFormat: '{value}',
                axisLine: const AxisLine(width: 0),
                majorTickLines:
                    const MajorTickLines(color: Colors.transparent)),
            series: <ChartSeries>[
              // Renders line chart
              StackedLineSeries<BatteryData, String>(
                  animationDuration: 2500,
                  width: 2,
                  dataSource: chartData,
                  xValueMapper: (BatteryData device, _) => device.time,
                  yValueMapper: (BatteryData device, _) => device.heat,
                  name: "Sıcaklık",
                  markerSettings: const MarkerSettings(isVisible: true)),

              StackedLineSeries<BatteryData, String>(
                  name: "Pil",
                  animationDuration: 2500,
                  width: 2,
                  dataSource: chartData,
                  xValueMapper: (BatteryData device, _) => device.time,
                  yValueMapper: (BatteryData device, _) => device.battery,
                  markerSettings: const MarkerSettings(isVisible: true)),
            ]));
  }

  Expanded _buildStatCard(String title, String count, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BatteryData {
  BatteryData(this.time, this.battery, this.heat);
  final String time;
  final double battery;
  final int heat;
}
