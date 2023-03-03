import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:upshot_flutter/screens/auth/auth.dart';
import 'package:upshot_flutter/screens/home.dart';
import 'package:upshot_flutter/screens/auth/login.dart';
import '../data/api.dart';
import '../shared/sp_helper.dart';
import '../data/user_login.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  final SPHelper helper = SPHelper();
  final API api = API();
  String errorMessage = "";
  UserLogin? user;

  @override
  void initState() {
    super.initState();
    helper.init().then((value) {
      user = helper.readUserLogin();
      var userEmail = json.encode(user?.email);
      // ignore: avoid_print
      print("User: $userEmail");
    });
    api.init();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Authentication();
    } else {
      return const HomeScreen();
    }
  }
}
