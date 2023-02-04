
import 'package:flutter/material.dart';
import 'package:upshot_flutter/shared/bottom_nav.dart';
import '../shared/menu_drawer.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activity'), automaticallyImplyLeading: false),
      bottomNavigationBar: const UpshotBottomNav(),
      body: const Center(child:Text('Activity'))
    );
  }
}