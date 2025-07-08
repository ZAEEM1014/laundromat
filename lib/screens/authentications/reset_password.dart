import 'package:flutter/material.dart';
import 'package:laundromat/constants/app_assets.dart';
import 'package:laundromat/constants/app_colors.dart';
import 'package:laundromat/routes/routes.dart';
import 'package:laundromat/widgets/primary_button.dart';
import 'package:laundromat/widgets/text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String from;
  const ResetPasswordScreen({super.key, required this.from});



  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String from = 'signin'; // Default origin

  @override
  void initState() {
    super.initState();
    debugPrint('ResetPasswordScreen opened from: ${widget.from}');
  }

  void _handleReset() {
    // TODO: Add real reset password logic here
    debugPrint('Redirecting after reset. From: ${widget.from}');

    if (widget.from == 'settings') {
      Navigator.pushReplacementNamed(context, AppRoutes.settingmain);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.signIn);
    }
  }


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

              // Logo
              Center(
                child: Image.asset(
                  AppAssets.bglogo,
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
                onPressed: _handleReset,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
