import 'package:shared_preferences/shared_preferences.dart';
import '../data/user_login.dart';
import 'dart:convert';

class SPHelper {
  static late SharedPreferences prefs;
  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future writeUserLogin(UserLogin ul) async {
    prefs.setString("user", json.encode(ul.toJson()));
  }

  Future clearUserLogin() async {
    prefs.remove("user");
  }

  Future writeServerAddress(String serveraddress) async {
    prefs.setString("server", serveraddress);
  }

  String? getServerAddress() {
    return prefs.getString("server");
  }

  Future writeUserUUID(String uuid) async {
    prefs.setString("uuid", uuid);
  }

  String? getUserUUID() {
    return prefs.getString("uuid");
  }

  UserLogin? readUserLogin() {
    var userlogin = prefs.getString("user");
    if (userlogin != null) {
      return UserLogin.fromJson(json.decode(userlogin));
    } else {
      return null;
    }
  }
}
