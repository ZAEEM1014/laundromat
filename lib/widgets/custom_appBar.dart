import 'package:flutter/material.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart'; // Make sure this path is correct

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 4,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: AppColors.primary,size: 30,),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      title: Image.asset(
        AppAssets.appbarlogo, // Replace with your logo path
        height: 45,
        width: 96,
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none, color: AppColors.primary,size: 30,),
              onPressed: () {
                // TODO: Handle notification tap
              },
            ),
            Positioned(
              right: 12,
              top: 12,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
