import 'package:flutter/material.dart';
import 'package:fluttermysql/models/sql_model.dart';
import 'package:fluttermysql/models/constant.dart';
import 'round_button.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email, password, username;
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
      register();
    }
  }

  void register() async {
    UserResult registerResult;
    await UserResult.sqlUserConnect(
            email: email,
            password: password,
            username: username,
            url: BaseURL.kRegisterUrl)
        .then((value) => registerResult = value);
    print(registerResult.value);
    if (registerResult.value == 1) {
      Navigator.pop(context);
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(registerResult.pesan),
        duration: Duration(seconds: 3),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kYellow,
      key: _scaffoldKey,
      body: Form(
        key: _key,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.all(20.0),
                height: 150.0,
                width: 150.0,
                child: Image.asset('assets/img/lemonlime.png'),
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
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Masukan username anda';
                  }
                  return null;
                },
                onSaved: (value) => username = value,
                decoration: kTextFieldDecoration.copyWith(hintText: 'Username'),
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
                textButton: 'Sign Up',
                getPressed: () {
                  check();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
