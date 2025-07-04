import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../routes/routes.dart';
import 'back_circular_icon.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback onEditProfile;
  final VoidCallback onSignOut;

  const CustomDrawer({
    super.key,
    required this.onEditProfile,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    const userName = "Leslie Alexander";

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Close icon
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Icon
                  BackCircleIcon(
                    onTap: () => Navigator.pop(context),
                    size: 25, // Control container size
                    iconSize: 15, // Control arrow icon size
                  ),

                  // Spacer to push content to center
                  const Spacer(),

                  // Column: Avatar + Name + Edit Profile (CENTERED)
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: AppColors.primary, width: 2),
                        ),
                        child: const CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(AppAssets.profilePhoto),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      const SizedBox(height: 7),
                      const Text(
                        'Leslie Alexander',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: AppColors.text,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),

                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero, // 🔥 removes extra space
                          minimumSize: Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.editProfile);
                        },
                        child: const Text(
                          "Edit Profile",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: AppColors.primary,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      // slight gap before underline
                      Container(
                        height: 0.8, // underline thickness
                        width: 80, // match width of text roughly
                        color: AppColors.primary,
                      ),
                    ],
                  ),

                  // Spacer to balance layout
                  const Spacer(),
                ],
              ),

              SizedBox(height: screenHeight * 0.05),

              // Wallet
              _buildSection(
                  "Wallet",
                  [
                    _drawerItem("View recent transactions", () {}),
                    _drawerItem("Add balance to wallet", () {}),
                  ],
                  context),

              // Track Order
              _buildSection(
                  "Track Order",
                  [
                    _drawerItem("Order status", () {}),
                    _drawerItem("Track your laundry", () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.trackorderaccess,
                      );
                    }),
                  ],
                  context),

              // Settings
              _buildSection(
                  "Account Privacy & Setting",
                  [
                    _drawerItem("Change Password", () {}),
                    _drawerItem("Setup 2 Factor Authentication", () {}),
                  ],
                  context),

              // Support
              _buildSection(
                  "Help and Support",
                  [
                    _drawerItem("Submit a ticket", () {}),
                    _drawerItem("View tickets", () {}),
                  ],
                  context),

              SizedBox(height: screenHeight * 0.014),

              // Sign Out
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.red,
                    backgroundColor: AppColors.lightred,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.signIn);
                  },
                  icon: SvgPicture.asset(
                    AppAssets.signOut,
                    height: 20,
                    width: 20,
                    // Optional: applies tint
                  ),
                  label: const Text(
                    "Sign Out",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerItem(String label, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          foregroundColor: AppColors.text,
          // ✅ Correct
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }

  Widget _buildSection(
      String title, List<Widget> children, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _getSectionIcon(title),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.043,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          ...children,
        ],
      ),
    );
  }

  Widget _getSectionIcon(String title) {
    switch (title) {
      case "Wallet":
        return SvgPicture.asset(
          AppAssets.wallet,
          height: 20,
          width: 20,
          // Optional: applies tint
        );
      case "Track Order":
        return SvgPicture.asset(
          AppAssets.trackOrder,
          height: 20,
          width: 20,
          // Optional: applies tint
        );
      case "Account Privacy & Setting":
        return SvgPicture.asset(
          AppAssets.setting,
          height: 20,
          width: 20,
          // Optional: applies tint
        );
      case "Help and Support":
        return SvgPicture.asset(
          AppAssets.support,
          height: 20,
          width: 20,
          // Optional: applies tint
        );
      default:
        return const SizedBox(height: 20, width: 20); // Placeholder if no match
    }
  }
}
