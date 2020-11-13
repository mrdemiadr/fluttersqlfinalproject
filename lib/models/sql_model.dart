import 'package:http/http.dart' as http;
import 'dart:convert';

class UserResult {
  int value;
  String pesan;
  String emailAPI;
  String usernamedAPI;
  int idUser;
  UserResult(
      {this.value, this.emailAPI, this.idUser, this.pesan, this.usernamedAPI});

  factory UserResult.createPostResult(Map<String, dynamic> data) {
    return UserResult(
      value: data['value'],
      pesan: data['message'],
      emailAPI: data['email'],
      usernamedAPI: data['username'],
    );
  }

  static Future<UserResult> sqlUserConnect(
      {String email, String username, String password, String url}) async {
    var response;
    if (username == null) {
      response = await http.post(url, body: {
        'email': email,
        'password': password,
      });
      return UserResult.createPostResult(jsonDecode(response.body));
    }
    response = await http.post(url, body: {
      'email': email,
      'password': password,
      'username': username,
    });
    return UserResult.createPostResult(jsonDecode(response.body));
  }
}
