import 'package:flutter/material.dart';
import 'package:laundromat/components/outlined_button.dart';
import 'package:laundromat/components/primary_button.dart';
import '../components/social_outlined_button.dart';
import '../components/text_field.dart';
import '../routes/routes.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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
            const SizedBox(height: 0),

            const Text(
              "Sign in",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            const CustomTextField(hintText: "Email"),
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
                  style: TextStyle(fontSize: 12, color: Colors.deepPurple),
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
              iconPath: "assets/facebook.png",
              onPressed: () {},
            ),
            const SizedBox(height: 12),
            SocialOutlinedButton(
              label: "Continue with Google",
              iconPath: "assets/google.png",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
