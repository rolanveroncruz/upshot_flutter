// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:upshot_flutter/data/directory.dart';
import 'package:upshot_flutter/screens/activity.dart';
import 'package:upshot_flutter/screens/insights.dart';
import 'package:upshot_flutter/screens/profile.dart';
import 'package:upshot_flutter/screens/splash.dart';
import 'screens/login.dart';
import 'screens/home.dart';

void main() {
  runApp(const UpshotApp());
}

class UpshotApp extends StatelessWidget {
  const UpshotApp({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MySplashScreen(),
      debugShowCheckedModeBanner: false,
      routes:{
        '/login':(context)=>Login(),
        '/home': (context)=>HomeScreen(),
        '/insights': (context)=>InsightsScreen(),
        '/activity': (context)=>ActivityScreen(),
        '/profile': (context)=>ProfileScreen()
      } 
    );
  }
}
