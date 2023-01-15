
import 'package:flutter/material.dart';
import '../shared/menu_drawer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upshot')),
      drawer: MenuDrawer(),
      body: const Center(child:Text('Profile'))
    );
  }
}