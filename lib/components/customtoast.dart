import 'package:flutter/material.dart';

Widget buildToast({
  @required String message,
  @required int value,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      color: value == 1 ? Colors.greenAccent : Colors.redAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(value == 1 ? Icons.check_circle : Icons.cancel,
            color: Colors.white),
        const SizedBox(height: 12),
        Text(message,
            style: const TextStyle(color: Colors.white, fontSize: 15)),
      ],
    ),
  );
}
