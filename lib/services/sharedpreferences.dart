import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static simpanPrefereneces(
      String emailPref, String usernamePref, String idUserPref) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('email', emailPref);
    await pref.setString('username', usernamePref);
    await pref.setString('id_user', idUserPref);
  }

  static Future<String> getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String usernameAPI = pref.getString('username');
    return usernameAPI;
  }

  static signOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
