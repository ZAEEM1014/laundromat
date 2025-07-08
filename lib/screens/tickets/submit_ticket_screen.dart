import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laundromat/constants/app_assets.dart';
import 'package:laundromat/routes/routes.dart';
import 'package:laundromat/widgets/gradient_button.dart';
import 'package:laundromat/widgets/social_outlined_button.dart';
import 'package:laundromat/widgets/text_field.dart';
import '../../constants/app_colors.dart';
import '../../widgets/custom_appBar.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/custom_navbar.dart';
import '../profile/edit_profile_screen.dart';

class SubmitTicketScreen extends StatefulWidget {
  const SubmitTicketScreen({super.key});

  @override
  State<SubmitTicketScreen> createState() => _SubmitTicketScreenState();
}

class _SubmitTicketScreenState extends State<SubmitTicketScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController _controller = TextEditingController();

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios,
                        size: 20, color: AppColors.text),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    splashRadius: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Explain Your Issue",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.text,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Email",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text),
                  ),
                  const SizedBox(height: 6),
                  CustomTextField(
                    hintText: 'LeslieAlexander@email.com',
                    controller: emailController,
                  ),
                  const SizedBox(height: 10),
                  const Text("Phone Number",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.text)),
                  const SizedBox(height: 6),
                  CustomTextField(
                    hintText: '+92 345 6756',
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 10),
                  const Text("Message",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.text)),
                  const SizedBox(height: 6),
                  SizedBox(
                    height: 160,
                    child: TextField(
                      controller: messageController,
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        hintText: "Write your issue here...",
                        filled: true,
                        fillColor: AppColors.textFieldFill,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SocialOutlinedButton(label: '', iconPath: AppAssets.download, onPressed: (){},color: AppColors.primary,),
                  const SizedBox(height: 16),
                  SizedBox(
                      width: double.infinity,
                      height: 53,
                      child: GradientButton(label: 'Save', onPressed: () {
                        FocusScope.of(context).unfocus();
                        final amount = _controller.text;

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => TicketSubmtted(
                            amount: amount,
                            onCheckItOut: () {
                              // Do something like navigating to wallet screen
                              debugPrint("Wallet checked!");
                            },
                          ),
                        );
                      }
                        ,)),
                  const SizedBox(height: 6),
                  const Center(
                    child: Text(
                      "Our support team will contact you within the next 24 hours",
                      style: TextStyle(color:AppColors.hintColor, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: 1,
        onTap: _onNavTapped,
      ),
    );
  }

}

class TicketSubmtted extends StatelessWidget {
  final String amount;
  final VoidCallback onCheckItOut;

  const TicketSubmtted({
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
                AppAssets.ticket_submited,
                height: 100,
              ),
              const SizedBox(height: 0),
              const Text(
                "Ticket Submitted",
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
                    const TextSpan(text: "Our support team will contact you in the next 24 hours"),


                  ],
                ),
              ),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,

                child: GradientButton(
                  label: 'View Tickets',
                  onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.viewticket);
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
