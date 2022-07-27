import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sensor_mobile/lineChart.dart';
import 'package:sensor_mobile/models/post.dart';
import 'package:sensor_mobile/services/remote_service.dart';

class StatsGrid extends StatefulWidget {
  static List<FlSpot>? spots = [FlSpot(0.0, 0.0)];
  static double minheat = 3000;
  static double maxheat = 0;

  @override
  _StatsGridState createState() => _StatsGridState();
}

class _StatsGridState extends State<StatsGrid> {
  List<Post>? posts;
  Timer? timer;
  var isLoaded = false;
  var len = 0;
  var lastheat = 0;
  var lastbattery = 0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) => getData());
  }

  getData() async {
    posts = await RemoteService().getPosts();
    if (posts != null) {
      setState(() {
        isLoaded = true;
        len = posts!.length;
        lastheat = posts![len - 1].sicaklik;
        lastbattery = posts![len - 1].pil;
      });
      StatsGrid.spots!.clear();
      for (int i = 0; i < 10; i++) {
        StatsGrid.spots!
            .add(FlSpot(i.toDouble(), posts![len - i - 1].pil.toDouble()));
        if (posts![len - i - 1].pil.toDouble() > StatsGrid.maxheat) {
          StatsGrid.maxheat = posts![len - i - 1].pil.toDouble();
        }
        if (posts![len - i - 1].pil.toDouble() < StatsGrid.minheat) {
          StatsGrid.minheat = posts![len - i - 1].pil.toDouble();
        }
      }
      print(StatsGrid.spots);
    }
  }

  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard('Last Heat Value', lastheat.toString() + "°",
                    Color.fromARGB(255, 115, 148, 170)),
                _buildStatCard(
                  'Battery Life',
                  lastbattery.toString() + '%',
                  Color.fromARGB(255, 63, 139, 158),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
