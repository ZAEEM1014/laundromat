import 'package:flutter/material.dart';
import 'package:laundromat/constants/constants.dart';
import 'package:laundromat/widgets/primary_button.dart';

class OrderFailureScreen extends StatelessWidget {
  final String soapId;
  final String date;

  const OrderFailureScreen({
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
              // Red error icon inside circle
              Container(
                height: 147,
                width: 147,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:AppColors.lightred,
                  border: Border.all(
                    color: AppColors.red,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    '!',
                    style: TextStyle(
                      fontSize: 80,
                      color: AppColors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              ),
              const SizedBox(height: 24),

              // Title
              const Text(
                "Oops! Something Went\nWrong",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  color: AppColors.red,
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
                      width: 101,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.lightred,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.cancel,
                              color: AppColors.red, size: 20),
                          SizedBox(width: 4),
                          Text(
                            "Failed",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
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

              // Retry Button
              PrimaryButton(
                label: 'Try Again',

                color: AppColors.red,
                onPressed: () {
                  Navigator.pop(context); // or retry logic
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
