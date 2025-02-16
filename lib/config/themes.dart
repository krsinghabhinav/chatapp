import 'package:chatapp/config/colors.dart';
import 'package:flutter/material.dart';

var lightTheme = ThemeData();
var darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    primary: dPrimaryColor,
    onPrimary: dOnBackgroundColor,
    background: dBackgroundColor,
    onBackground: dOnContainerColor,
    primaryContainer: dContainerColor,
    onPrimaryContainer: dOnContainerColor,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
        fontSize: 30,
        color: dPrimaryColor,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w800),
    headlineMedium: TextStyle(
        fontSize: 28,
        color: dOnBackgroundColor,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(
        fontSize: 20,
        color: dOnBackgroundColor,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w500),
  ),
);
