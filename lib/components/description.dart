import 'package:flutter/material.dart';
import '../constants.dart';

class DescriptionWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool readOnly;

  const DescriptionWidget({
    Key key,
    this.controller,
    this.readOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: TextFormField(
          minLines: 1,
          maxLines: 3,
          readOnly: readOnly,
          cursorColor: kPrimaryColor,
          controller: controller,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            focusedBorder: kOutlineInput,
            border: kOutlineInput,
            enabledBorder: kOutlineInput,
            labelText: 'Description',
            labelStyle:
                const TextStyle(backgroundColor: const Color(0x00000000)),
            hintText: 'Write a short description',
          ),
        ),
      ),
    );
  }
}
