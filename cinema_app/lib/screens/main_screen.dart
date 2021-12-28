import 'package:cinema_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

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
