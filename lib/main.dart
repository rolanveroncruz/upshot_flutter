// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:upshot_flutter/data/api.dart';

import 'package:upshot_flutter/screens/activity.dart';
import 'package:upshot_flutter/screens/authcheck.dart';
import 'package:upshot_flutter/screens/insights.dart';
import 'package:upshot_flutter/screens/ongoing_journeys.dart';
import 'package:upshot_flutter/screens/profile.dart';
import 'package:upshot_flutter/screens/splash.dart';
import 'package:upshot_flutter/shared/sp_helper.dart';
import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp();
  runApp(const UpshotApp());
}

class UpshotApp extends StatefulWidget {
  const UpshotApp({super.key});

  @override
  State<UpshotApp> createState() => _UpshotAppState();
}

class _UpshotAppState extends State<UpshotApp> {
  final SPHelper helper = SPHelper();
  final API api = API();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Upshot',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MySplashScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/auth': (context) => AuthCheck(),
          '/home': (context) => HomeScreen(),
          '/insights': (context) => InsightsScreen(),
          '/activity': (context) => ActivityScreen(),
          '/profile': (context) => ProfileScreen(),
          '/ongoing': (context) => OngoingJourneys(),
        });
  }
}
