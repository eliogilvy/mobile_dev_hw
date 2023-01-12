import 'package:flutter/material.dart';

class Styles {
  static TextStyle titleStyle() {
    return TextStyle(
      fontSize: 30.0,
      fontFamily: 'Jost',
      color: Colors.white,
    );
  }

  static TextStyle formStyle() {
    return TextStyle(
      fontSize: 15.0,
      fontFamily: 'Jost',
      color: Colors.white,
    );
  }

  static AppBar myAppBar(String text) {
    return AppBar(
      title: Text(
        text,
        style: titleStyle(),
      ),
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 70, 70, 70),
    );
  }

  static Color myBackground() {
    return Color.fromARGB(255, 51, 50, 50);
  }

  static InputDecoration myFormStyle(String text) {
    return InputDecoration(
      labelText: text,
      labelStyle: formStyle(),
    );
  }
}
