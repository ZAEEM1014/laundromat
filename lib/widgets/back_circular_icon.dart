import 'package:flutter/material.dart';
import '../constants/constants.dart';

class BackCircleIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final double size;       // Size of the circular container
  final double iconSize;   // Size of the arrow icon

  const BackCircleIcon({
    super.key,
    this.onTap,
    this.size = 48,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Navigator.pop(context),
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: iconSize,
        ),
      ),
    );
  }
}
