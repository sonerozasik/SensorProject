import 'package:flutter/material.dart';
import 'package:sensor_mobile/customAppBar.dart';
import 'package:sensor_mobile/dashboard_grid.dart';
import 'package:sensor_mobile/lineChart.dart';
import 'package:sensor_mobile/notificationList.dart';
import 'package:sensor_mobile/timeline.dart';

class homeScreen extends StatefulWidget {
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              sliver: SliverToBoxAdapter(
                child: StatsGrid(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              sliver: SliverToBoxAdapter(
                child: LineChartView(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              sliver: SliverToBoxAdapter(
                child: AlertList(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              sliver: SliverToBoxAdapter(
                child: TimeLine(),
              ),
            ),
          ]),
    );
  }
}
