import 'package:flutter/material.dart';
import 'package:laundromat/constants/app_assets.dart';
import 'package:laundromat/constants/app_colors.dart';

import '../widgets/outlined_button.dart';
import '../widgets/primary_button.dart';
import '../widgets/text_field.dart';
import '../routes/routes.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          children: [
            const SizedBox(height: 25),
            Image.asset(
              AppAssets.bglogo,
              width: 280,
              height: 160,
            ),
            const SizedBox(height: 6),
            const Text(
              "Create an Account",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 20),
            const CustomTextField(hintText: "First Name"),
            const SizedBox(height: 12),
            const CustomTextField(hintText: "Last name"),
            const SizedBox(height: 12),
            const CustomTextField(hintText: "Email"),
            const SizedBox(height: 12),
            const CustomTextField(hintText: "Phone number"),
            const SizedBox(height: 12),
            const CustomTextField(hintText: "Password", isObscure: true),
            const SizedBox(height: 20),
            PrimaryButton(
              label: "Sign up",
              onPressed: () {},
            ),
            const SizedBox(height: 14),
            const Text.rich(
              TextSpan(
                text: "By signing up, you agree with ",
                style: TextStyle(fontSize: 12, color: AppColors.text),
                children: [
                  TextSpan(
                    text: "Terms of Service",
                    style: TextStyle(color: Colors.blue),
                  ),
                  TextSpan(text: " and "),
                  TextSpan(
                    text: "Privacy Policy",
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            CustomOutlinedButton(
              label: "Sign in",
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.signIn);
              },
            )
          ],
        ),
      ),
    );
  }


}
