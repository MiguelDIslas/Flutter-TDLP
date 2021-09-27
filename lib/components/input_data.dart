import 'package:flutter/material.dart';
import '../constants.dart';

class InputData extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final Function function;
  final bool disable;
  final TextEditingController controller;
  final bool error;
  final String messageError;

  const InputData({
    Key key,
    this.label,
    this.hint,
    this.icon,
    this.function,
    this.disable,
    this.controller,
    this.error,
    this.messageError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextField(
        readOnly: disable,
        cursorColor: kPrimaryColor,
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            focusedBorder: kOutlineInput,
            border: kOutlineInput,
            enabledBorder: kOutlineInput,
            labelText: label,
            labelStyle:
                const TextStyle(backgroundColor: const Color(0x00000000)),
            hintText: hint,
            suffixIcon: GestureDetector(
              onTap: function,
              child: Icon(icon),
            ),
            errorText: error ? messageError : null),
      ),
    );
  }
}
