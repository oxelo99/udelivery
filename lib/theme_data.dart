import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static Color buttonColor(context) {
    if (MediaQuery.of(context).platformBrightness == Brightness.light) {
      return const Color.fromARGB(255, 24, 166, 64);
    } else {
      return const Color.fromARGB(255, 241, 148, 58);
    }
  }

  static Color textColor(context) {
    if (MediaQuery.of(context).platformBrightness == Brightness.light) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  build(context) {}

  static ThemeData get lightTheme {
    return ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 24, 166, 64),
        ),
        primaryColor: const Color.fromARGB(255, 24, 166, 64),
        canvasColor: const Color.fromARGB(255, 24, 166, 64),
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
        textTheme: GoogleFonts.kanitTextTheme(),
        hintColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.black),
            hintStyle: TextStyle(color: Colors.black),
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 24, 166, 64)),
                borderRadius: BorderRadius.all(Radius.circular(25.0)))));
  }

  static ThemeData get darkTheme {
    return ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 33, 33, 33),
        ),
        primaryColor: const Color.fromARGB(255, 24, 166, 64),
        canvasColor: const Color.fromARGB(255, 241, 148, 58),
        scaffoldBackgroundColor: const Color.fromARGB(255, 48, 48, 48),
        brightness: Brightness.light,
        textTheme: GoogleFonts.kanitTextTheme(),
        hintColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.white),
            hintStyle: TextStyle(color: Colors.white),
            //fillColor: Colors.white,
            //filled: false,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 241, 148, 58)),
                borderRadius: BorderRadius.all(Radius.circular(25.0)))));
  }

  static const MaterialColor lightPrimaryColor = MaterialColor(
    0xFF18A640,
    <int, Color>{
      50: Color(0xFFF2F9F2),
      100: Color(0xFFDBF1DB),
      200: Color(0xFFB8E8B8),
      300: Color(0xFF94DF94),
      400: Color(0xFF76D876),
      500: Color(0xFF58CF58),
      600: Color(0xFF50C950),
      700: Color(0xFF46C146),
      800: Color(0xFF3CB83C),
      900: Color(0xFF2B9C2B),
    },
  );

  static const MaterialColor darkPrimaryColor = MaterialColor(
    0xFF212121,
    {
      50: Color(0xFFECEFF1),
      100: Color(0xFFCFD8DC),
      200: Color(0xFFB0BEC5),
      300: Color(0xFF90A4AE),
      400: Color(0xFF78909C),
      500: Color(0xFF607D8B),
      600: Color(0xFF546E7A),
      700: Color(0xFF455A64),
      800: Color(0xFF37474F),
      900: Color(0xFF263238),
    },
  );
}
