
import 'package:flutter/material.dart';



class ByteBankTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData? customIcon;
  final TextInputType? keyboardType;

  ByteBankTextField({
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.customIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(
        fontSize: 24.0,
      ),
      decoration: InputDecoration(
        icon: customIcon != null ? Icon(customIcon) : null,
        labelText: labelText,
        hintText: hintText,
      ),
      keyboardType: keyboardType,
    );
  }
}
