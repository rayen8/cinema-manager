import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String menuTitle;
  final Icon menuIcon;
  final Function handler;

  const MenuItem({
    Key? key,
    required this.menuTitle,
    required this.menuIcon,
    required this.handler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(menuTitle),
      leading: menuIcon,
      trailing: const Icon(Icons.arrow_right),
      onTap: () {
        handler(context);
      },
    );
  }
}
