import 'package:flutter/material.dart';
import 'package:fluttermysql/models/constant.dart';
import 'package:fluttermysql/view/splash_screen.dart';
import 'view/home_screen.dart';
import 'view/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: kLightGreen,
        iconTheme: IconThemeData(color: kLightGreen),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        SplashScreen.id: (context) => SplashScreen(),
      },
    );
  }
}
