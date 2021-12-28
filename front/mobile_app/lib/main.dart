import 'package:cinema_app/providers/user_provider.dart';
import 'package:cinema_app/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider _userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    return StreamProvider.value(
      value: _userProvider.loggedUser$,
      initialData: null,
      child: MaterialApp(
        title: 'Cinema App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: const Wrapper(),
      ),
    );
  }
}
