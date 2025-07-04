// lib/widgets/custom_snackbar.dart
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomSnackbar extends StatelessWidget {
  final String message;

  const CustomSnackbar({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: AppColors.primary,
      width: double.infinity,
      child: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
