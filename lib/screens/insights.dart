
import 'package:flutter/material.dart';
import 'package:upshot_flutter/shared/bottom_nav.dart';
import '../shared/menu_drawer.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Insights'), automaticallyImplyLeading: false),
      bottomNavigationBar: const UpshotBottomNav(),
      body: const Center(child:Text('Insights'))
    );
  }
}