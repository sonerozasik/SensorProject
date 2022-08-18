import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 63, 139, 158),
      elevation: 0.0,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        iconSize: 28.0,
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: <Widget>[],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
