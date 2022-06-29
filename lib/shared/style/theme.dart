import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lis/shared/style/colors.dart';

ThemeData ligththeme = ThemeData(
  fontFamily: 'ar_font',
  primarySwatch: defaultColor,
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0.0,
      titleTextStyle: TextStyle( fontFamily: 'ar_font',
          color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      iconTheme: IconThemeData(color: Colors.black)),
  scaffoldBackgroundColor: Colors.white,
);

//Dark Theme
ThemeData darktheme = ThemeData(
  primarySwatch: defaultColor,
  fontFamily: 'ar_font',
  appBarTheme: AppBarTheme(
      backgroundColor: HexColor('#333739'),
      centerTitle: true,
      elevation: 0.0,
      titleTextStyle: const TextStyle(fontFamily: 'ar_font',
          color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('#333739'),
          statusBarIconBrightness: Brightness.light),
      iconTheme: IconThemeData(color: Colors.white)),

  scaffoldBackgroundColor: Colors.black,


);
