import 'dart:async';

import 'package:flutter/material.dart';
import 'package:upshot_flutter/screens/authcheck.dart';
import '../../shared/sp_helper.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  final SPHelper helper = SPHelper();
  @override
  void initState() {
    helper.init();
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AuthCheck())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.deepPurple.shade400,
        child: Image.asset(
          "lib/assets/images/upshot-logo.png",
          scale: 0.25,
        ));
  }
}
