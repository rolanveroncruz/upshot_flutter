import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'dart:convert';

class SPHelper {
  static late SharedPreferences prefs;
  Future init() async{
    prefs = await SharedPreferences.getInstance();
  }
  Future writeUserLogin(UserLogin ul) async {
    prefs.setString("user",json.encode(ul.toJson()));
  }
}