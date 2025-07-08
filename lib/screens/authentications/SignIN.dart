import 'package:flutter/material.dart';
import 'package:laundromat/constants/app_assets.dart';

import '../../constants/app_colors.dart';
import '../../routes/routes.dart';
import '../../widgets/outlined_button.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/social_outlined_button.dart';
import '../../widgets/text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                AppAssets.bglogo,
                width: 280,
                height: 160,
              ),
              const SizedBox(height: 0),
        
              Text(
                "Sign in",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color:AppColors.text,
                ),
              ),
              const SizedBox(height: 20),
        
              const CustomTextField(hintText: "Email",),
              const SizedBox(height: 16),
              const CustomTextField(hintText: "Password", isObscure: true),
        
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.forgotPassword);
                  }, // Add your logic
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: const Text(
                    "Forgot Password",
                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600, color: Colors.deepPurple),
                  ),
                ),
              ),
              const SizedBox(height: 2),
        
              PrimaryButton(
                label: "Sign In",
        
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.mainNav);
                }, // Add sign-in logic
              ),
              const SizedBox(height: 10),
        
              CustomOutlinedButton(
                label: "Sign Up",
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.signUp);
                }, // Add sign-up logic
              ),
              const SizedBox(height: 15),
        
              const Text(
                "Or",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
              ),
              const SizedBox(height: 16),
        
              SocialOutlinedButton(
                label: "Continue with Facebook",
                iconPath: AppAssets.facebook,
                color: AppColors.border,
                onPressed: () {},
              ),
              const SizedBox(height: 12),
              SocialOutlinedButton(
                label: "Continue with Google",
                iconPath:AppAssets.google,
                color: AppColors.border,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
