// lib/widgets/custom_navbar.dart

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,

      color: AppColors.primary,
      index: currentIndex,
      animationDuration: const Duration(milliseconds: 300),
      onTap: onTap,
      items: [
        SvgPicture.asset(
          AppAssets.home,
          height: 30,
          // Optional: applies tint
        ),
        Icon(
          Icons.add,
          size: 35,
          color: AppColors.white,
        ),
        SvgPicture.asset(
          AppAssets.order,
          height: 30,
          // Optional: applies tint
        ),
      ],
    );
  }
}
