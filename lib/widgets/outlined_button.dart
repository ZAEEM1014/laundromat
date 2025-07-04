// lib/widgets/outlined_button.dart
import 'package:flutter/material.dart';
import 'package:laundromat/constants/app_colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color; // optional color
  final double? fontSize; // optional font size

  const CustomOutlinedButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color finalColor = color ?? AppColors.primary;
    final double finalFontSize = fontSize ?? 24;

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: finalColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: finalFontSize,
            color: finalColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
