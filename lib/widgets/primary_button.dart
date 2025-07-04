import 'package:flutter/material.dart';
import 'package:laundromat/constants/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final dynamic label; // Can be String or Widget
  final VoidCallback onPressed;
  final double fontSize;
  final Color color;

  const PrimaryButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.fontSize = 24.0,
    this.color = AppColors.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (label is String) {
      child = Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      );
    } else if (label is Widget) {
      child = label;
    } else {
      throw Exception("Label must be either String or Widget");
    }

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: child,
      ),
    );
  }
}
