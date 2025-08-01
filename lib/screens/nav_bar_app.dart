// Updated NavBarApp with persistent navigation (no flickering)

import 'package:flutter/material.dart';
import '../widgets/custom_appBar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_navbar.dart';
import '../constants/app_colors.dart';
import 'home/home_screen.dart';
import 'order_details/order_detail_screen.dart';
import 'orders/new_order_screen.dart';
import 'profile/edit_profile_screen.dart';

class NavBarApp extends StatefulWidget {
  final int selectedIndex;
  const NavBarApp({super.key, this.selectedIndex = 0});

  @override
  State<NavBarApp> createState() => _NavBarAppState();
}

class _NavBarAppState extends State<NavBarApp> {
  late int _selectedIndex;

  final List<Widget> _pages = [
    const HomePage(),
    NewOrderScreen(),
    const OrdersDetailScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onTabTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent back navigation from NewOrderScreen
        return false;
      },
      child: Scaffold(
        appBar: const CustomAppBar(),
        drawer: CustomDrawer(
          onEditProfile: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const EditProfileScreen()),
            );
          },
          onSignOut: () {
            // Sign-out logic
          },
        ),
        backgroundColor: AppColors.background,
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: CustomNavBar(
          currentIndex: _selectedIndex,
          onTap: _onTabTapped,
        ),
      ),
    );
  }
}
