import 'package:ecommerce_app/authentication/login.dart';
import 'package:ecommerce_app/components/theme.dart';
import 'package:ecommerce_app/modules/home_bottom.dart';
import 'package:ecommerce_app/modules/home_screen.dart';
import 'package:ecommerce_app/modules/my_cart.dart';
import 'package:ecommerce_app/modules/product_details.dart';
import 'package:ecommerce_app/modules/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appTheme(),
      home: HomeScreen(),
    );
  }
}

