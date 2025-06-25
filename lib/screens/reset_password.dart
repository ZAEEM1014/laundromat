import 'package:flutter/material.dart';
import 'package:laundromat/components/primary_button.dart';
import 'package:laundromat/constants/constants.dart';

import '../components/text_field.dart';
import '../routes/routes.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Logo (replace with your image asset if needed)
              Center(
                child: Image.asset(
                  'assets/SignupLOGO.png',
                  width: 280,
                  height: 160,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Reset Password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),

              const SizedBox(height: 27),

              const CustomTextField(
                hintText: 'Old password',
                isObscure: true,
              ),

              const SizedBox(height: 16),

              const CustomTextField(
                hintText: 'New password',
                isObscure: true,
              ),

              const SizedBox(height: 16),

              const CustomTextField(
                hintText: 'Confirm password',
                isObscure: true,
              ),

              const SizedBox(height: 32),

              PrimaryButton(
                label: 'Reset Password',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.signIn);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
