import 'package:flutter/material.dart';

class Styles {
  static TextStyle titleStyle(Color color) {
    return TextStyle(
      fontSize: 30.0,
      fontFamily: 'Jost',
      color: color,
    );
  }

  static TextStyle formStyle(double size) {
    return TextStyle(
      fontSize: size,
      fontFamily: 'Jost',
      color: Colors.white,
    );
  }

  static TextStyle taskStyle(double size) {
    return TextStyle(
      fontSize: size,
      fontFamily: 'Jost',
      color: Colors.black,
    );
  }

  static AppBar myAppBar(String text) {
    return AppBar(
      title: Text(
        text,
        style: titleStyle(Colors.white),
      ),
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 70, 70, 70),
    );
  }

  static Color myBackground() {
    return Color.fromARGB(255, 51, 50, 50);
  }

  static Color buttonBackground() {
    return Color.fromARGB(255, 247, 242, 157);
  }

  static InputDecoration myFormStyle(String text) {
    return InputDecoration(
      border: InputBorder.none,
      counterStyle: formStyle(11),
      labelText: text,
      labelStyle: formStyle(formSize()),
    );
  }

  static double formSize() {
    return 15.0;
  }

  static double taskSize() {
    return 20.0;
  }
}
