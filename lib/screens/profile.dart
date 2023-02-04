
import 'package:flutter/material.dart';
import 'package:upshot_flutter/shared/bottom_nav.dart';
import 'package:upshot_flutter/shared/sp_helper.dart';
import '../shared/menu_drawer.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  SPHelper helper = SPHelper();

  @override
  void initState(){
    super.initState();
    helper.init();
  }
  
  void _signOut(BuildContext context){
    helper.clearUserLogin().then((value) => {
        Navigator.pushNamed(context, "/login")
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), automaticallyImplyLeading: false),
      drawer: const MenuDrawer(),
      body: Center(
        child:  TextButton(
          onPressed: () => _signOut(context),
          child: const Text("Sign Out"))),
      bottomNavigationBar: const UpshotBottomNav(),
      );
  }
}