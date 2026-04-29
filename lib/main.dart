import 'package:ecommerce_app/authentication/login.dart';
import 'package:ecommerce_app/components/theme.dart';
import 'package:ecommerce_app/modules/home_bottom.dart';
import 'package:ecommerce_app/modules/home_screen.dart';
import 'package:ecommerce_app/modules/my_cart.dart';
import 'package:ecommerce_app/modules/product_details.dart';
import 'package:ecommerce_app/modules/splash_screen.dart';
import 'package:ecommerce_app/services/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {

SystemChrome.setSystemUIOverlayStyle(
  SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,    
  ),
);
  runApp(

    MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CartState())],
   child:  const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appTheme(),
      home: SplashScreen(),
    );
  }
}

