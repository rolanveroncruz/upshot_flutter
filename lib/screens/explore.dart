import 'package:flutter/material.dart';
import '../shared/menu_drawer.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Upshot')),
        drawer: const MenuDrawer(),
        body: const Center(child: Text('Profile')));
  }
}
