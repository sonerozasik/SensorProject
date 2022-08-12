import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sensor_mobile/constants.dart';
import 'package:sensor_mobile/lineChart.dart';
import 'package:sensor_mobile/models/post.dart';
import 'package:sensor_mobile/services/remote_service.dart';
import 'package:searchfield/searchfield.dart';
import 'package:dropdown_search/dropdown_search.dart';

class StatsGrid extends StatefulWidget {
  @override
  _StatsGridState createState() => _StatsGridState();
}

class _StatsGridState extends State<StatsGrid> {
  final LineChartView lv = const LineChartView();
  final devicecontroller = TextEditingController(text: "2");

  List<Post>? posts;
  Timer? timer;
  var len = 0;
  var lastheat = 0;
  var lastbattery = 0;

  @override
  void initState() {
    super.initState();
    getdata1();
    LineChartViewState().getData();
    timer = Timer.periodic(const Duration(seconds: 30), (Timer t) {
      getdata1();
      LineChartViewState().getData();
    });
  }

  getdata1() async {
    LineChartViewState().getData();
    posts = await RemoteService().getPosts();
    if (posts != null) {
      setState(() {
        len = posts!.length;
        lastheat = posts![len - 1].sicaklik;
        lastbattery = posts![len - 1].pil;
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
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
                      LineChartViewState().getData();
                    },
                    controller: devicecontroller,
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
