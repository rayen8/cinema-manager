import 'package:cinema_app/screens/villes_screen.dart';
import 'package:cinema_app/screens/settings_screen.dart';
import 'package:cinema_app/widgets/menu_item.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> menus = [
    {
      'title': 'Home',
      'icon': const Icon(Icons.home),
      'page': const VillesScreen(),
    },
    {
      'title': 'Settings',
      'icon': const Icon(Icons.settings),
      'page': const SettingsScreen(),
    },
    {
      'title': 'Contact',
      'icon': const Icon(Icons.contact_mail),
      'page': const SettingsScreen(),
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cinema Page"),
      ),
      body: const Center(
        child: Text("Home cinema..."),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("./assets/profile.png"),
                  radius: 20,
                ),
              ),
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.white, Colors.green])),
            ),
            ...menus.map(
              (item) {
                return Column(
                  children: [
                    const Divider(
                      color: Colors.green,
                    ),
                    MenuItem(
                      menuTitle: item['title'],
                      menuIcon: item['icon'],
                      handler: (context) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => item['page'],
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
