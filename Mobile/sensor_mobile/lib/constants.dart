import 'package:flutter/material.dart';

const koyumavi = Color.fromARGB(255, 103, 149, 182);
const acikmavi = Color.fromARGB(255, 186, 201, 214);
const suyesilimsi = Color.fromARGB(255, 150, 206, 201);
const beige = Color(0xFFF6F2D4);

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color.fromARGB(255, 46, 100, 114),
  borderRadius: BorderRadius.circular(20.0),
  boxShadow: [
    BoxShadow(
      color: Color.fromARGB(255, 65, 126, 150),
      blurRadius: 2.0,
      offset: Offset(0, 2),
    ),
  ],
);
