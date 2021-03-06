import 'package:flutter/material.dart';

import 'text_field.dart';
import '../constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final IconData suffixIcon;
  final bool obscureText;
  final TextInputType inputType;
  final TextEditingController controller;
  final Function functionShow;

  const RoundedInputField(
      {Key key,
      this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      this.suffixIcon,
      this.obscureText,
      this.inputType = TextInputType.text,
      this.controller,
      this.functionShow});

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged == null ? (value) {} : onChanged,
        style: TextStyle(color: Colors.grey[700], fontSize: 13),
        controller: controller,
        obscureText: obscureText,
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[700], fontSize: 13),
          icon: Icon(icon, color: kPrimaryColor),
          suffixIcon: GestureDetector(
              onTap: functionShow == null ? () {} : functionShow,
              child: Icon(suffixIcon, color: kPrimaryColor)),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
