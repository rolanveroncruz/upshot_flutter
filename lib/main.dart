import 'package:flutter/material.dart';

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