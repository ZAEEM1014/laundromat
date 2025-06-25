import 'package:flutter/material.dart';
import 'package:laundromat/components/primary_button.dart';
import 'package:laundromat/constants/constants.dart';

import '../routes/routes.dart'; // ✅ import your AppColors

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final List<TextEditingController> _controllers =
  List.generate(4, (index) => TextEditingController());

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget buildOtpField(int index) {
    return Container(
      width: 60,
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: TextField(
        controller: _controllers[index],
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.text, // ✅ text color
        ),
        decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.zero,
          filled: true,
          fillColor: AppColors.textFieldFill, // ✅ fill color
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppColors.primary), // ✅ border color
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppColors.primary, width: 2), // ✅ focused border
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 3) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // ✅ background color
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/SignupLOGO.png',
                width: 280,
                height: 160,
              ),
              const SizedBox(height: 20),

              // Title
              const Text(
                "Enter Verification Code",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text, // ✅ title text color
                ),
              ),
              const SizedBox(height: 10),

              // Subtitle
              const Text(
                "Input the code we sent to +1-XXX-XXX-X258\nto access your account.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Label
              const Text(
                "Enter code Here",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.text, // ✅ label color
                ),
              ),
              const SizedBox(height: 13),

              // OTP Inputs
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) => buildOtpField(index)),
              ),

              const SizedBox(height: 30),

              // Verify Button
              PrimaryButton(
                label: "Verify Now",
                onPressed: () {

                  final otp = _controllers.map((c) => c.text).join();
                  print("Entered OTP: $otp");
                  Navigator.pushNamed(context, AppRoutes.resetPassword);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
