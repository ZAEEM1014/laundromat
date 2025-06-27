// lib/widgets/custom_text_field.dart
import 'package:flutter/material.dart';
import 'package:laundromat/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isObscure;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.isObscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.text, // 👈 custom hint text color
          fontSize: 16,
        ),

        filled: true,
        fillColor: AppColors.textFieldFill,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
