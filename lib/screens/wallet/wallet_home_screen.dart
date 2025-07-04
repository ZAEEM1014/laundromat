import 'package:flutter/material.dart';
import 'package:laundromat/constants/app_colors.dart';
import 'package:laundromat/constants/app_gradient.dart';
import 'package:laundromat/widgets/custom_appBar.dart';
import 'package:laundromat/widgets/custom_drawer.dart';
import 'package:laundromat/widgets/custom_navbar.dart';
import 'package:laundromat/widgets/outlined_button.dart';
import 'package:laundromat/widgets/primary_button.dart';
import 'package:laundromat/widgets/gradient_button.dart';
import '../../data/wallet_home_data.dart';
import '../edit_profile_screen.dart';

class WalletHomeScreen extends StatefulWidget {
  final double addedAmount;

  const WalletHomeScreen({super.key, this.addedAmount = 0.0});

  @override
  State<WalletHomeScreen> createState() => _WalletHomeScreenState();
}

class _WalletHomeScreenState extends State<WalletHomeScreen> {
  double walletBalance = 103.00;

  @override
  void initState() {
    super.initState();
    walletBalance += widget.addedAmount;
  }

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Wallet Balance Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: AppGradients.yellowToPink,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Suds Wallet", style: TextStyle(color: AppColors.text,fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(
                      "\$${walletBalance.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 61,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: PrimaryButton(
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.add, size: 20, color: Colors.white),
                                const SizedBox(width: 4),
                                const Text(
                                  'Add Funds',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/add-funds');
                            },
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          flex: 1,
                          child: CustomOutlinedButton(
                            label: 'Wallet History',
                            onPressed: () {},
                            color: AppColors.text,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Saved Ways to Pay
              const Text(
                "Saved Ways to Pay",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.textFieldFill,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/user.jpg'),
                      radius: 20,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Personal", style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Visa 0493", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Add New Card Button
              SizedBox(
                width: double.infinity,
                child: GradientButton(
                  label: 'Add NEW Card',
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 24),

              // Ledger Section
              const Text(
                "Your Laundry Ledger",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              ...walletLedgerEntries.map((entry) => ledgerItem(
                entry.date,
                entry.title,
                entry.amount,
                entry.color,
              )),
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

  Widget ledgerItem(String date, String title, String amount, Color amountColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.textFieldFill,
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.hintColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.text,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: amountColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
