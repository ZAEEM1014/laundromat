import 'package:flutter/material.dart';
import 'package:laundromat/constants/app_colors.dart';

class AddPreferencesButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AddPreferencesButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightBlue,
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
        side: const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
      ),
      child: const Text(
        "Add preferences",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.text,
        ),
      ),
    );
  }
}
