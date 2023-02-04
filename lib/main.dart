// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:upshot_flutter/data/directory.dart';
import 'package:upshot_flutter/screens/activity.dart';
import 'package:upshot_flutter/screens/insights.dart';
import 'package:upshot_flutter/screens/profile.dart';
import 'screens/login.dart';
import 'screens/home.dart';

void main() {
  runApp(const UpshotApp());
}

class UpshotApp extends StatefulWidget {
  const UpshotApp({super.key});

  @override
  State<UpshotApp> createState() => _UpshotAppState();
}

class _UpshotAppState extends State<UpshotApp> {
   bool isLoggedIn = true;
   ServerDirectory serverDirectory = ServerDirectory();

  @override
  void initState() {
    super.initState();
    serverDirectory.init();
  }

    
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: ThemeData(primarySwatch: Colors.blue),
      routes:{
        '/login':(context)=>Login(),
        '/home': (context)=>HomeScreen(),
        '/insights': (context)=>InsightsScreen(),
        '/activity': (context)=>ActivityScreen(),
        '/profile': (context)=>ProfileScreen()
      }, initialRoute: '/login',
    );
  }
}
