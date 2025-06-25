import 'package:flutter/material.dart';
import 'package:laundromat/screens/SignIN.dart';
import 'package:laundromat/screens/SignUp.dart';
import 'package:laundromat/screens/forgot_password.dart';
import 'package:laundromat/screens/reset_password.dart';

import '../screens/nav_bar_app.dart'; // ✅ Import reset password screen

class AppRoutes {
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String mainNav = '/main-nav';// ✅ New route

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case mainNav:
        return MaterialPageRoute(builder: (_) => const NavBarApp());// ✅ Case added
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined')),
          ),
        );
    }
  }
}
