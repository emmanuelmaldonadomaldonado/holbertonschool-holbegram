// Archivo: lib/widgets/text_field.dart

import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isPassword;
  final String hintText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;

  const TextFieldInput({
    super.key,
    required this.controller,
    required this.isPassword,
    required this.hintText,
    this.suffixIcon,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: isPassword,
      cursorColor: const Color.fromARGB(218, 226, 37, 24),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
