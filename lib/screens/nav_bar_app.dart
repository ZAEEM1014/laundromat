import 'package:flutter/material.dart';
import 'package:laundromat/constants/constants.dart';


import 'home_screen.dart';
import 'new_order_screen.dart';
import 'order_screen.dart';

class NavBarApp extends StatefulWidget {
  final int selectedIndex;
  const NavBarApp({super.key, this.selectedIndex = 0});

  @override
  State<NavBarApp> createState() => _NavBarAppState();
}

class _NavBarAppState extends State<NavBarApp> {
  late int _selectedIndex;

  final List<Widget> _pages = const [
    HomePage(),
    NewOrderPage(),
    OrdersPage(),
  ];

  final List<String> _labels = ['Home', 'New Order', 'Orders'];
  final List<IconData> _icons = [Icons.home, Icons.add, Icons.receipt_long];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _pages[_selectedIndex],
      bottomNavigationBar: _buildCustomNavBar(),
    );
  }

  Widget _buildCustomNavBar() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(3, (index) {
          final isSelected = _selectedIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? Colors.white : Colors.transparent,
                  ),
                  child: Icon(
                    _icons[index],
                    size: index == 1 ? 30 : 24,
                    color: isSelected ? AppColors.primary : Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _labels[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
