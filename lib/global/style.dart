import 'dart:ui';

import 'package:flutter/material.dart';

Color themeBackgroundColor = const Color.fromRGBO(8, 87, 156, 1.0);
Color themeForegroundColor = const Color.fromRGBO(255, 255, 255, 1.0);

TextStyle splashScreenTitleText() {
  return TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.bold,
    color: themeForegroundColor,
  );
}

TextStyle appBarText() {
  return TextStyle(
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: themeForegroundColor,
  );
}
TextStyle screenHeadingText() {
  return TextStyle(
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    fontSize: 32,
    color: themeBackgroundColor,
  );
}

ButtonStyle actionBtnWithThemeColor() {
  return ElevatedButton.styleFrom(
    backgroundColor: themeBackgroundColor,
    shadowColor: Colors.black,
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20), // <-- Radius
    ),
  );
}
ButtonStyle actionBtnWithRedColor() {
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.red,
    shadowColor: Colors.black,
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20), // <-- Radius
    ),
  );
}

ButtonStyle actionBtnWithReverseThemeColor() {
  return ElevatedButton.styleFrom(
    backgroundColor: themeForegroundColor,
    shadowColor: Colors.black,
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20), // <-- Radius
    ),
  );
}

TextStyle buttonThemeColorText() {
  return TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: themeForegroundColor,
  );
}
TextStyle buttonReverseThemeColorText() {
  return TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: themeBackgroundColor,
  );
}
TextStyle blackColorText() {
  return const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: Colors.black,
  );
}


TextStyle simpleTextWithThemeColor(){
  return TextStyle(
    fontSize: 14,
    color: themeForegroundColor,
  );
}
TextStyle simpleTextWithReverseThemeColor(){
  return TextStyle(
    fontSize: 14,
    color: themeBackgroundColor,
  );
}

TextStyle greyColorButtonText() {
  return const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: Color.fromRGBO(59, 59, 59, 1.0),
  );
}
TextStyle greyColorText() {
  return const TextStyle(color: Colors.blueGrey);
}


InputDecoration textFieldsDec() {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        width: 2,
        color: themeBackgroundColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        width: 2,
        color: Colors.red,
      ),
    ),
  );
}

BoxDecoration textButtonContainerDecoration() {
  return BoxDecoration(
    color: const Color.fromRGBO(252, 252, 252, 1.0),
    border: Border.all(color: Colors.black, width: 2, style: BorderStyle.solid),
    borderRadius: BorderRadius.circular(10),
  );
}

BoxDecoration leaveRequestTableBoxDecoration(){
  return BoxDecoration(
    color: Colors.transparent,
    border: Border.all(color: Colors.black, width: 1, style: BorderStyle.solid),
  );
}