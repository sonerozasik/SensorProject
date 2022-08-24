import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sensor_mobile/LoginScreen.dart';
import 'package:sensor_mobile/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Sensor APP for Intern Project

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();

  //Return String
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var remb = prefs.getBool('rememberMe');
  print(remb);
  runApp(MaterialApp(
    title: "Sensor App",
    debugShowCheckedModeBanner: false,
    home: remb != null ? homeScreen() : LoginScreen(),
  ));
}
