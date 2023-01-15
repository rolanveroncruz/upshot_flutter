import 'package:flutter/material.dart';
import 'package:upshot_flutter/screens/home.dart';
import 'package:upshot_flutter/screens/explore.dart';
import 'package:upshot_flutter/screens/profile.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: buildMenuItems(context),
    ));
  }

  List<Widget> buildMenuItems(BuildContext context) {
    final List<String> menuTitles = [
      'Home',
      'Explore',
      'Weather',
      'Profile'
    ];
    List<Widget> menuItems = [];
    menuItems.add(const DrawerHeader(
        decoration: BoxDecoration(color: Colors.blueAccent),
        child: Text('Emerging Manager',
            style: TextStyle(color: Colors.white, fontSize: 28))));
    for (var element in menuTitles){
      Widget screen = Container();
      menuItems.add(ListTile(
          title: Text(element, style: const TextStyle(fontSize: 18)),
          onTap: () {
            switch (element) {
              case 'Home':
                screen = const HomeScreen();
                break;
              case 'Explore':
                screen = const ExploreScreen();
                break;
              case 'Weather':
                screen = const HomeScreen();
                break;
              case 'Training':
                screen = const ProfileScreen();
                break;
            }
            Navigator.of(context).pop();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => screen));
          }));
    }
    return menuItems;
  }
}
