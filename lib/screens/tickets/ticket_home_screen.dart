import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laundromat/routes/routes.dart';
import '../../constants/app_colors.dart';
import '../../data/ticket_home_data.dart';
import '../../widgets/custom_appBar.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/custom_navbar.dart';
import '../edit_profile_screen.dart';


class TicketHomeScreen extends StatefulWidget {
  const TicketHomeScreen({super.key});

  @override
  State<TicketHomeScreen> createState() => _TicketHomeScreenState();
}

class _TicketHomeScreenState extends State<TicketHomeScreen> {

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
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
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
      body:ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: supportOptions.length,
        itemBuilder: (context, index) {
          final item = supportOptions[index];
          return GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, AppRoutes.submitticket);

            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.textFieldFill,
                  borderRadius: BorderRadius.circular(40),

                  border: Border.all(
                    color: AppColors.border, // ✅ Border color
                            // Optional: border width
                  ),

                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: const Color(0xFFEAEAFF),
                      child: SvgPicture.asset(
                        item['icon']!,
                        width: 20,
                        height: 20,

                      ),
                    ),

                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title']!,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.text
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['subtitle']!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.hintColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: 1,
        onTap: _onNavTapped,
      ),
    );
  }

}


