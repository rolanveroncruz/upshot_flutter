import 'package:flutter/material.dart';
import '../shared/sp_helper.dart';
import '../shared/login.dart';
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
   late UserLogin userlogin;
   late SPHelper helper;

  @override
  void initState() {
    // TODO: implement initState
    helper.init();
    super.initState();

  }
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        // appBar: AppBar(title: const Text('Upshot')),
        body: Login()
      )
    );
  }
}