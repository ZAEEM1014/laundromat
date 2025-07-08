import 'package:flutter/material.dart';
import 'package:laundromat/constants/app_assets.dart';
import 'package:laundromat/constants/app_colors.dart';
import 'package:laundromat/widgets/text_field.dart';
import '../../routes/routes.dart';
import '../../widgets/custom_navbar.dart';
import '../../widgets/gradient_button.dart';

class TrackOrderAccess extends StatefulWidget {
  const TrackOrderAccess({super.key});

  @override
  State<TrackOrderAccess> createState() => _TrackOrderAccessState();
}

class _TrackOrderAccessState extends State<TrackOrderAccess> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _orderIdController = TextEditingController();

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () => Navigator.pop(context),
        ),
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(left: 50, top: 10, bottom: 6),
            alignment: Alignment.centerLeft,
            child: const Text(
              "Order Detail",
              style: TextStyle(
                color: AppColors.text,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text("Email",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
              const SizedBox(height: 4),
              CustomTextField(
                hintText: "Enter your email",
                controller: _emailController,
              ),
              const SizedBox(height: 16),
              const Text("Order ID",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
              const SizedBox(height: 4),
              CustomTextField(
                hintText: "Enter Order ID",
                controller: _orderIdController,
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  height: 243,
                  width: 269,
                  child: Image.asset(AppAssets.order_placed),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: GradientButton(
                    label: 'Get Your Bubble Bill',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.trackorder,
                        arguments: {
                          'date': '16-04-2025',
                          'soapId': _orderIdController.text,
                          'email': _emailController.text,
                          'currentStep': 3,
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: 1,
        onTap: _onNavTapped,
      ),
    );
  }
}
