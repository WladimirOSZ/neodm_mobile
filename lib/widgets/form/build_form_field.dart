import 'package:flutter/material.dart';

class BuildFormFiled extends StatelessWidget {
  const BuildFormFiled({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.obscureText = false,
  });

  final String hintText;
  final Icon icon;
  final TextEditingController controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: const Color.fromARGB(0, 167, 140, 140)),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(5),
        ),
        prefixIcon: Icon(
          icon.icon,
          color: Colors.white,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
      ),
      style: TextStyle(color: Colors.white),
      // The validator receives the text that the user has entered.
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Value can't be blank";
        }
        return null;
      },
      controller: controller,
      obscureText: obscureText,
    );
  }
}
