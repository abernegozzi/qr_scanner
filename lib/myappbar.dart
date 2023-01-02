import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height = 52.0;

  @override
  Size get preferredSize => Size.fromHeight(height);

  const MyAppBar({
    Key? key,
    required this.title,
    required this.actions,
  }) : super(key: key);

  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 8,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.red, Colors.orange],
        )),
      ),
      title: Text(title),
      actions: actions,
    );
  }
}
