import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:upshot_flutter/screens/auth/auth.dart';
import 'package:upshot_flutter/screens/home.dart';
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
    user = helper.readUserLogin();
    var userEmail = json.encode(user?.email);
    // ignore: avoid_print
    print("In Auth Check initState, user: $user");
    // ignore: avoid_print
    print("In Auth Check initState(), userEmail: $userEmail");
    api.init();
  }

  @override
  Widget build(BuildContext context) {
    print("In Auth Check build, user==null is ${user == null}");
    if (user == null) {
      return const Authentication();
    } else {
      return const HomeScreen();
    }
  }
}
