import 'package:flutter/material.dart';
import 'package:laundromat/constants/app_colors.dart';
import '../../data/wallet_data.dart';
import '../../widgets/custom_appBar.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/custom_navbar.dart';
import '../profile/edit_profile_screen.dart';
import 'components/card_form.dart';
import 'components/saved_payment_card.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
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
        onSignOut: () {
          // Sign-out logic
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, size: 18, color: AppColors.text),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    splashRadius: 20,
                  ),
                  const Text(
                    "Add Card",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.text,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              CardForm(
                card1: "5468",
                card2: "5468",
                card3: "5468",
                card4: "5468",
                month: "07",
                year: "2018",

                onSave: () {
                  // Save card logic here
                },
              ),
              SizedBox(height: 20,),

              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Current Payment Method",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...paymentMethods.map((method) => PaymentMethodCard(
                      title: method['title']!,
                      label: method['label']!,
                      card: method['card']!,
                      imagePath: method['image']!,
                    )),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: 1,
        onTap: _onNavTapped,
      ),
    );
  }
}