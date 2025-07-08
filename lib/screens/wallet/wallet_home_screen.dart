import 'package:flutter/material.dart';
import 'package:laundromat/constants/app_assets.dart';
import 'package:laundromat/constants/app_colors.dart';
import 'package:laundromat/constants/app_gradient.dart';
import 'package:laundromat/routes/routes.dart';
import 'package:laundromat/screens/wallet/components/recent_transactions.dart';
import 'package:laundromat/widgets/custom_appBar.dart';
import 'package:laundromat/widgets/custom_drawer.dart';
import 'package:laundromat/widgets/custom_navbar.dart';
import 'package:laundromat/widgets/outlined_button.dart';
import 'package:laundromat/widgets/primary_button.dart';
import 'package:laundromat/widgets/gradient_button.dart';
import '../../data/wallet_data.dart';
import '../profile/edit_profile_screen.dart';
import 'components/saved_payment_card.dart';

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
                    const Text("Suds Wallet",
                        style: TextStyle(
                            color: AppColors.text,
                            fontWeight: FontWeight.bold)),

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
                                const Icon(Icons.add,
                                    size: 20, color: Colors.white),
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: AppColors.text),
              ),
              const SizedBox(height: 8),
              ...paymentMethods.map((method) => PaymentMethodCard(
                title: method['title']!,
                label: method['label']!,
                card: method['card']!,
                imagePath: method['image']!,
              )),

              const SizedBox(height: 16),

              // Add New Card Button
              SizedBox(
                width: double.infinity,
                child: GradientButton(
                  label: 'Add NEW Card',
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.addcard);
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Ledger Section
              const Text(
                "Your Laundry Ledger",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: AppColors.text),
              ),
              const SizedBox(height: 10),

              ...walletLedgerEntries.take(3).map((entry) => LedgerItem(
                date: entry.date,
                title: entry.title,
                amount: entry.amount,
                amountColor: entry.color,
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


}
