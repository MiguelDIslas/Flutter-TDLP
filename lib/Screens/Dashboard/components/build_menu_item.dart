import 'package:flutter/material.dart';

Widget buildMenuItem({
  @required String text,
  @required IconData icon,
  @required Function function,
}) {
  const color = Colors.white;
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ),
    title: Text(
      text,
      style: TextStyle(color: color),
    ),
    onTap: function,
  );
}
