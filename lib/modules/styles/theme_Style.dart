
import 'package:flutter/material.dart';
import '../shared/constants/costants.dart';
ThemeData lightTheme =ThemeData(

    primarySwatch: defultColore,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        titleSpacing: 10.0,
        color: Colors.white,
        elevation: 0.0,
        titleTextStyle: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,

        )
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.deepOrange,
      elevation: 20.0,
    ),
    textTheme:const TextTheme(
        bodyText1: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize:20.0,
          color: Colors.black,
        )
    ),


);