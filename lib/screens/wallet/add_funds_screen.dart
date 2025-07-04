import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laundromat/constants/app_assets.dart';
import 'package:laundromat/routes/routes.dart';
import 'package:laundromat/widgets/gradient_button.dart';

import '../../constants/app_colors.dart';
import '../../widgets/custom_appBar.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/custom_navbar.dart';
import '../edit_profile_screen.dart';

class AddFunds extends StatefulWidget {
  const AddFunds({super.key});

  @override
  State<AddFunds> createState() => _AddFundsState();
}

class _AddFundsState extends State<AddFunds> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

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
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // dismiss keyboard on outside tap
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                "Top Up Your Suds Wallet",
                style: TextStyle(
                  color: AppColors.text,
                  fontWeight: FontWeight.w700,
                  fontSize:24,

                ),
              ),
              const SizedBox(height: 10),

              // Hidden TextField + Tap Container
              // Replace this Stack with this:
              Container(
                height: 111,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Text(
                      "\$",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        style: const TextStyle(fontSize: 24),
                        decoration: const InputDecoration(
                          hintText: "Add amount",
                          border: InputBorder.none,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Gradient Button
             SizedBox(
                 width: double.infinity,
                 child: GradientButton(label: 'Add To Wallet', onPressed: () {
                   FocusScope.of(context).unfocus();
                   final amount = _controller.text;

                   showDialog(
                     context: context,
                     barrierDismissible: false,
                     builder: (context) => WalletRefilledDialog(
                       amount: amount,
                       onCheckItOut: () {
                         // Do something like navigating to wallet screen
                         debugPrint("Wallet checked!");
                       },
                     ),
                   );
                 }
                   ,))
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
class WalletRefilledDialog extends StatelessWidget {
  final String amount;
  final VoidCallback onCheckItOut;

  const WalletRefilledDialog({
    super.key,
    required this.amount,
    required this.onCheckItOut,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 350,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppAssets.wallet_refilled,
                height: 100,
              ),
              const SizedBox(height: 0),
              const Text(
                "Suds Wallet Refilled!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.hintColor,
                  ),
                  children: [
                    const TextSpan(text: "Cha-ching!"),
                    TextSpan(
                      text: " \$$amount ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),
                    const TextSpan(text: "is now bubbling in your wallet."),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: GradientButton(
                  label: 'Check it out',
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.wallethome,
                      arguments: double.tryParse(amount) ?? 0.0,
                    );

                    // Execute action
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

