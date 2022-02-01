import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Image.asset(
      "assets/images/logo.png",
      height: 40,
    ),
  );
}

InputDecoration textFieldInputDecoration(String hint) {
  return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white54),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 16);
}

TextStyle mediumTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 17);
}

TextStyle mediumUnderlinedTextStyle() {
  return TextStyle(
      color: Colors.white, fontSize: 17, decoration: TextDecoration.underline);
}

TextStyle mediumBlackTextStyle() {
  return TextStyle(color: Colors.black, fontSize: 17);
}
