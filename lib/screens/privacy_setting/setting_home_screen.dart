import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../routes/routes.dart';
import '../../widgets/custom_appBar.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/custom_navbar.dart';
import '../profile/edit_profile_screen.dart';

class SettingHomeScreen extends StatefulWidget {
  const SettingHomeScreen({super.key});

  @override
  State<SettingHomeScreen> createState() => _SettingHomeScreenState();
}

class _SettingHomeScreenState extends State<SettingHomeScreen> {
  bool isNotificationsEnabled = true;
  bool isTwoFactorEnabled = true;

  void _onNavTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/main-nav');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/new-order');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/orders');
        break;
    }
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100, // Fixed height for uniformity
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: AppColors.text,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.text,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 12),
              SizedBox(
                width: 52, // 🔒 Constrain switch or any trailing widget
                child: trailing,
              ),
            ]
          ],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(
        onEditProfile: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const EditProfileScreen()),
          );
        },
        onSignOut: () {
          // Handle sign-out logic
        },
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 40),
        children: [
          _buildSettingTile(
            icon: Icons.notifications_active_outlined,
            title: "Enable Notifications",
            subtitle: "Allow us to send you push notifications",
            trailing: Switch(
              value: isNotificationsEnabled,
              onChanged: (value) {
                setState(() {
                  isNotificationsEnabled = value;
                });
              },
              activeColor: AppColors.primary,
              inactiveThumbColor: AppColors.primary.withOpacity(0.3),
              activeTrackColor: Colors.transparent,
              inactiveTrackColor: Colors.transparent,
              trackOutlineColor: MaterialStateProperty.resolveWith((states) {
                return states.contains(MaterialState.selected)
                    ? AppColors.primary
                    : AppColors.primary.withOpacity(0.3);
              }),
            ),
          ),
          _buildSettingTile(
            icon: Icons.lock_outline,
            title: "Change Password",
            subtitle: "Change your account password",
            onTap: () {
              print("Navigating to reset-password with 'from': settings");
              Navigator.pushNamed(
                context,
                AppRoutes.resetPassword,
                arguments: {'from': 'settings'},
              );

            },
          ),
          _buildSettingTile(
            icon: Icons.verified_user_outlined,
            title: "Two-Factor Authentication",
            subtitle: "Help protect your account from unauthorized access by second authentication method.",
            trailing: Switch(
              value: isTwoFactorEnabled,
              onChanged: (value) {
                setState(() {
                  isTwoFactorEnabled = value;
                });
              },
              activeColor: AppColors.primary,
              inactiveThumbColor: AppColors.primary.withOpacity(0.3),
              activeTrackColor: Colors.transparent,
              inactiveTrackColor: Colors.transparent,
              trackOutlineColor: MaterialStateProperty.resolveWith((states) {
                return states.contains(MaterialState.selected)
                    ? AppColors.primary
                    : AppColors.border;
              }),
            ),
          ),
          _buildSettingTile(
            icon: Icons.privacy_tip_outlined,
            title: "Privacy Policy",
            subtitle: "View our privacy policy",
            onTap: () {
              Navigator.pushNamed(context, '/privacy-policy');
            },
          ),
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: 1,
        onTap: _onNavTapped,
      ),
    );
  }
}
