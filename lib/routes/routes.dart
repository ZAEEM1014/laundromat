import 'package:flutter/material.dart';
import 'package:laundromat/screens/SignIN.dart';
import 'package:laundromat/screens/SignUp.dart';
import 'package:laundromat/screens/forgot_password.dart';
import 'package:laundromat/screens/reset_password.dart';
import 'package:laundromat/screens/track_order_access.dart';
import 'package:laundromat/screens/wallet/add_funds_screen.dart';
import 'package:laundromat/screens/wallet/wallet_home_screen.dart';

import '../screens/edit_profile_screen.dart';
import '../screens/nav_bar_app.dart';
import '../screens/order_billing/order_bill.dart';
import '../screens/order_confirmation_screen.dart';
import '../screens/Track_order_screen.dart';
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
  static const String trackorder = '/track-order';
  static const String orderBill = '/order-bill';
  static const String trackorderaccess = '/track-order-access';
  static const String wallethome = '/wallet-home';
  static const String addfunds = '/add-funds';



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
      case trackorder:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => TrackOrderScreen(
            date: args['date'] ?? '',
            soapId: args['soapId'] ?? '',
            email: args['email'] ?? '',
            currentStep: int.tryParse(args['currentStep'].toString()) ?? 0,
          ),
        );
      case orderBill:
        final args = settings.arguments as Map<String, dynamic>?;

        final weight = args?['laundryWeight'];
        final rate = args?['pricePerPound'];
        final total = args?['totalPrice'];
        final date = args?['date']?.toString();     // Ensure it's a String
        final soapId = args?['soapId']?.toString();


        if (weight is double && rate is double && total is double) {
          return MaterialPageRoute(
            builder: (_) => OrderBillScreen(
              laundryWeight: weight,
              pricePerPound: rate,
              totalPrice: total,
              date: date ?? '',           // ✅ use actual value from `args`
              soapId: soapId ?? '',
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('Missing or invalid billing data')),
            ),
          );
        }


      case trackorderaccess:
        return MaterialPageRoute(builder: (_) => const TrackOrderAccess());
      case wallethome:
        final addedAmount = settings.arguments as double? ?? 0.0;
        return MaterialPageRoute(builder: (_) => WalletHomeScreen(addedAmount: addedAmount));
      case addfunds:
        return MaterialPageRoute(builder: (_) => const AddFunds());



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
