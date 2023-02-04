import 'package:flutter/material.dart';
import 'package:upshot_flutter/shared/bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), automaticallyImplyLeading: false),
      body: const Center(child:Text('Home')),
      bottomNavigationBar: const UpshotBottomNav(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          
        },
      ));
  }
}