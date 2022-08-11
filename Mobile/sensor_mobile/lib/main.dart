import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sensor_mobile/LoginScreen.dart';

//Sensor APP for Intern Project

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MaterialApp(
    title: "Sensor App",
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
  ));
}
