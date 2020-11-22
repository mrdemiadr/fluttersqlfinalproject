import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseURL {
  static const kLoginUrl = 'https://fluttersqlcrud.000webhostapp.com/login.php';
  static const kRegisterUrl =
      'https://fluttersqlcrud.000webhostapp.com/register.php';
  static const kAddnewsrUrl =
      'https://fluttersqlcrud.000webhostapp.com/addNews.php';
  static const kDetailUrl =
      'https://fluttersqlcrud.000webhostapp.com/detailNews.php';
  static const kEditUrl =
      'https://fluttersqlcrud.000webhostapp.com/editNews.php';
  static const kDeleteUrl =
      'https://fluttersqlcrud.000webhostapp.com/deleteNews.php';
  static const kImageUrl = 'https://fluttersqlcrud.000webhostapp.com/upload/';
}

Color kLightGreen = Color(0xFFB2DBBF);
Color kDarkerGreen = Color(0xFF70C1B3);
Color kYellow = Color(0xFFF3FFBD);

const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Color.fromRGBO(255, 255, 255, 0.3),
  focusColor: Color.fromRGBO(211, 211, 211, 1.0),
  hintText: '',
  hintStyle: TextStyle(
    color: Color(0xFF70C1B3),
    fontWeight: FontWeight.w800,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent, width: 3.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green, width: 3.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent, width: 3.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green, width: 3.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
);
