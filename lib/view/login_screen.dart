// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttermysql/models/constant.dart';
import 'package:fluttermysql/view/home_screen.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttermysql/models/sql_model.dart';
import 'package:fluttermysql/services/sharedpreferences.dart';
import 'package:fluttermysql/view/signup_screen.dart';
import 'round_button.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);
  static const String id = 'loginscreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email, password;
  final _key = GlobalKey<FormState>();
  bool _secureText = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void showHideText() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  void check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      login();
    }
  }

  void login() async {
/*     final response = await http
        .post('https://fluttersqlcrud.000webhostapp.com/login.php', body: {
      'email': email,
      'password': password,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    String emailAPI = data['email'];
    String usernamedAPI = data['username']; */
    UserResult userResult;
    await UserResult.sqlUserConnect(
            email: email, password: password, url: BaseURL.kLoginUrl)
        .then((value) => userResult = value);
    if (userResult.value == 1) {
      SharedPref.simpanPrefereneces(
          userResult.emailAPI, userResult.usernamedAPI, userResult.idUser);
      print('dari sql ${userResult.idUser}');
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushNamed(context, HomeScreen.id);
      });
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(userResult.pesan),
        duration: Duration(seconds: 3),
      ));
    }
  }

/*   _simpanPrefereneces(String emailPref, String usernamePref) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('email', emailPref);
    await pref.setString('username', usernamePref);
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kLightGreen,
      key: _scaffoldKey,
      body: Form(
        key: _key,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: 'animasilogo',
                child: Container(
                  margin: EdgeInsets.all(20.0),
                  height: 150.0,
                  width: 150.0,
                  child: Image.asset('assets/img/lemonlime.png'),
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Masukan email anda';
                  }
                  return null;
                },
                onSaved: (value) => email = value,
                decoration: kTextFieldDecoration.copyWith(hintText: 'Email'),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                obscureText: _secureText,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Masukan password anda';
                  }
                  return null;
                },
                onSaved: (value) => password = value,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: showHideText,
                    icon: Icon(
                        _secureText ? Icons.visibility_off : Icons.visibility),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              FullWidthRoundButton(
                textButton: 'Login',
                getPressed: () {
                  check();
                },
              ),
              InkWell(
                child: Container(
                  margin: EdgeInsets.only(top: 20.0, right: 20.0),
                  child: Text(
                    'Skip Login ->>',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 20.0,
                        decoration: TextDecoration.underline,
                        color: Colors.white),
                  ),
                ),
                onTap: () => Navigator.pushNamed(context, HomeScreen.id),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          onVerticalDragStart: (details) {
            showModalBottomSheet(
                isScrollControlled: true,
                enableDrag: true,
                context: context,
                builder: (context) => SignUpScreen());
          },
          child: Container(
            height: 80.0,
            color: kLightGreen,
            child: Container(
              child: Column(
                children: [
                  Icon(Icons.arrow_upward),
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      color: kLightGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: kYellow,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
