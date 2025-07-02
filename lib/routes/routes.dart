import 'package:flutter/material.dart';
import 'package:laundromat/screens/SignIN.dart';
import 'package:laundromat/screens/SignUp.dart';
import 'package:laundromat/screens/forgot_password.dart';
import 'package:laundromat/screens/reset_password.dart';

import '../screens/edit_profile_screen.dart';
import '../screens/nav_bar_app.dart';
import '../screens/order_confirmation_screen.dart';
import '../screens/order_detail_screen.dart';
import '../screens/order_failure_screen.dart';
import '../screens/order_success_screen.dart';

class AppRoutes {
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String mainNav = '/main-nav';
  static const String newOrder = '/new-order';
  static const String orders = '/orders';
  static const String editProfile = '/edit-profile';
  static const String orderConfirmation = '/order-confirmation';
  static const String orderSuccess = '/order-success';
  static const String orderFailure = '/order-failure';
  static const String orderDetail = '/order-detail';



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
        return MaterialPageRoute(builder: (_) => const NavBarApp(selectedIndex: 0));
      case newOrder:
        return MaterialPageRoute(builder: (_) => const NavBarApp(selectedIndex: 1));
      case orders:
        return MaterialPageRoute(builder: (_) => const NavBarApp(selectedIndex: 2));
      case editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case orderSuccess:
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => OrderSuccessScreen(
            soapId: args['soapId'] ?? '',
            date: args['date'] ?? '',
          ),
        );
      case orderFailure:
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => OrderFailureScreen(
            soapId: args['soapId'] ?? '',
            date: args['date'] ?? '',
          ),
        );
      case orderDetail:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => OrderDetailScreen(
            date: args['date'] ?? '',
            soapId: args['soapId'] ?? '',
            email: args['email'] ?? '',
            currentStep: int.tryParse(args['currentStep'].toString()) ?? 0,
          ),
        );



      case orderConfirmation:
        return MaterialPageRoute(
          builder: (context) => const OrderConfirmationScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined')),
          ),
        );
    }
  }
}
