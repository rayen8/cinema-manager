import 'package:cinema_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Latest Movies"),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body: const Center(
        child: Text("Home cinema..."),
      ),
    );
  }
}
