import 'package:flutter/material.dart';
import 'package:sensor_mobile/customAppBar.dart';
import 'package:sensor_mobile/dashboard_grid.dart';

class homeScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: Drawer(),
      drawerEnableOpenDragGesture: false,
      body: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              sliver: SliverToBoxAdapter(
                child: StatsGrid(),
              ),
            ),
          ]),
    );
  }
}
