import 'package:flutter/material.dart';
import 'package:laundromat/constants/app_colors.dart';
import 'package:laundromat/widgets/primary_button.dart';

import '../routes/routes.dart';

class OrderSuccessScreen extends StatelessWidget {
  final String soapId;
  final String date;

  const OrderSuccessScreen({
    super.key,
    required this.soapId,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Static checkmark icon inside circle (no animation)
              Container(
                height: 147,
                width: 147,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.check,
                  size: 40,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 24),
              // Main title
              Text(
                "Woohoo! Your Sudsy\nOrder’s In",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              // Soap ID
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Soap ID: ",
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.text,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "#$soapId",
                    style: const TextStyle(
                      fontSize: 24,
                      color: AppColors.text,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Date
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Date    ",
                    style: TextStyle(fontSize: 20, color: AppColors.hintColor),
                  ),
                  const SizedBox(width: 70),
                  Text(
                    date,
                    style: const TextStyle(fontSize: 20, color: AppColors.text),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Status
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 45.0),
                    child: Text(
                      "Status ",
                      style:
                      TextStyle(fontSize: 20, color: AppColors.hintColor),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 43.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreen,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.check_circle,
                              color: Colors.green, size: 20),
                          SizedBox(width: 4),
                          Text(
                            "Success",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Button
              PrimaryButton(
                label: 'Return Home Sparkly Clean',
                fontSize: 20.0,
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.mainNav);// Implement navigation or callback here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
