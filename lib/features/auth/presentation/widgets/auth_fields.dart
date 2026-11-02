import 'package:flutter/material.dart';

class AuthFields extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;
  const AuthFields({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
      obscureText: isObscureText,
      // obscuringCharacter: "1",
    );
  }
}
