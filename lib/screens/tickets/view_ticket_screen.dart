import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../widgets/custom_appBar.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/custom_navbar.dart';
import '../profile/edit_profile_screen.dart';

class ViewTicketScreen extends StatefulWidget {
  const ViewTicketScreen({super.key});

  @override
  State<ViewTicketScreen> createState() => _ViewTicketScreenState();
}

class _ViewTicketScreenState extends State<ViewTicketScreen> {
  int selectedIndex = 0;

  final List<String> tabHeaders = [
    'Resolved Tickets',
    'Tickets in Process',
    'Cancelled Tickets',
  ];

  final List<String> statuses = ['Resolved', 'Processing', 'Cancelled'];
  final List<Color> colors = [
    AppColors.lightGreen,
    AppColors.lightBlue,
    AppColors.lightred,
  ];

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
        onSignOut: () {},
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          /// Tab Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.primary),
              ),
              child: Row(
                children: List.generate(3, (index) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? AppColors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          statuses[index],
                          style: TextStyle(
                            color: selectedIndex == index
                                ? Colors.white
                                : AppColors.text,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// Section Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                tabHeaders[selectedIndex],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          /// Ticket List
          Expanded(
            child: TicketList(
              status: statuses[selectedIndex],
              color: colors[selectedIndex],
            ),
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

class TicketList extends StatelessWidget {
  final String status;
  final Color color;

  const TicketList({super.key, required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 7,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              title: const Text(
                "Order ID #12345",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
              subtitle: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("80.65\$", style: TextStyle(color: AppColors.text)),
                  Text("25-may-2025", style: TextStyle(color: AppColors.text)),
                ],
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
        status,
        style: const TextStyle(
        color: AppColors.text,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        ),
        ),

        ),
            ),
            const Divider(height: 1),
          ],
        );
      },
    );
  }
}
