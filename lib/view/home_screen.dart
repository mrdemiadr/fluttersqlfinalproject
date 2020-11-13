import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttermysql/services/sharedpreferences.dart';
import 'package:fluttermysql/view/login_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'homescreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String usernameAPI = '';

  @override
  void initState() {
    super.initState();
    _getPref();
  }

  _getPref() async {
    await SharedPref.getPref().then((value) {
      setState(() {
        usernameAPI = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0;
    return Scaffold(
      appBar: AppBar(
        leading: Hero(
          tag: 'animasilogo',
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: Image.asset('assets/img/lemonlime.png'),
          ),
        ),
        title: Text('Welcome $usernameAPI'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              SharedPref.signOut();
              Navigator.pushReplacementNamed(context, LoginScreen.id);
            },
          )
        ],
      ),
      body: Center(
        child: Text('Ini Halaman HomeScreen'),
      ),
    );
  }
}
