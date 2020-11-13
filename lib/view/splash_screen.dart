import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splashscreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _getPref();
  }

  _getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String _emailAPI = pref.getString('email');
    if (_emailAPI != '' && _emailAPI != null) {
      Navigator.pushReplacementNamed(context, HomeScreen.id);
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'animasilogo',
          child: Container(
            margin: EdgeInsets.all(20.0),
            height: 75.0,
            width: 75.0,
            child: Image.asset('assets/img/lemonlime.png'),
          ),
        ),
      ),
    );
  }
}
