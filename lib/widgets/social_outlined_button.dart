import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_colors.dart';

class SocialOutlinedButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final VoidCallback onPressed;
  final Color? color; // ✅ Optional color

  const SocialOutlinedButton({
    super.key,
    required this.label,
    required this.iconPath,
    required this.onPressed,
    this.color, // ✅ Accepting optional color
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveColor = color ?? AppColors.border;

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: SvgPicture.asset(
          iconPath,
          height: 24,
           // ✅ Apply color to SVG
        ),
        label: Text(
          label,
          style: TextStyle(color: AppColors.text),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: effectiveColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
