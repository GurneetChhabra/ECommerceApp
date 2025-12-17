import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme() {
  return ThemeData(
      scaffoldBackgroundColor: const Color(0xFFFAF2EC),
      useMaterial3: true,
      textTheme: TextTheme(
        headlineLarge: TextStyle(
            fontSize: 23, color: Colors.black, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(
            fontSize: 20,
            color: const Color(0xFF2A2A2A),
            fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(
            fontSize: 18,
            color: const Color(0xFF2A2A2A),
            fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(fontSize: 18, color: const Color.fromARGB(197, 0, 0, 0)),
        bodyMedium: TextStyle(fontSize: 16, color: Colors.black),
        bodySmall: TextStyle(fontSize: 14, color: Colors.black),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(12),
      ));
}
