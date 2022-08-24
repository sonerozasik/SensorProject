import 'package:flutter/material.dart';
import 'package:sensor_mobile/changeUsernameScreen.dart';
import 'package:sensor_mobile/changepasswordScreen.dart';
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
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF0B5A9C),
              ),
              child: Text(
                'Innova Bilişim Çözümleri A.Ş.',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Text(
              "  Edit User",
            ),
            ListTile(
              leading: Icon(
                Icons.edit,
              ),
              title: const Text('Change Username'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangeUserName()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.password,
              ),
              title: const Text('Change Password'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangePwScreen()));
              },
            ),
          ],
        ),
      ),
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
