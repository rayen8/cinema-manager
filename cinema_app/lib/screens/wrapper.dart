import 'package:cinema_app/models/user.dart';
import 'package:cinema_app/screens/authenticate/authenticate.dart';
import 'package:cinema_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return user == null ? const Authenticate() : const HomeScreen();
  }
}
