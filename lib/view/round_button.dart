import 'package:flutter/material.dart';
import 'package:fluttermysql/models/constant.dart';

class FullWidthRoundButton extends StatelessWidget {
  final String textButton;
  final Function getPressed;
  FullWidthRoundButton({this.getPressed, this.textButton});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: kDarkerGreen,
      padding: EdgeInsets.all(18.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      onPressed: getPressed,
      child: Text(
        textButton,
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    );
  }
}
