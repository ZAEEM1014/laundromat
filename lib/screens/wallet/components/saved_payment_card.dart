import 'package:flutter/material.dart';
import 'package:laundromat/constants/app_colors.dart';
import 'package:laundromat/routes/routes.dart';

class PaymentMethodCard extends StatelessWidget {
  final String title;
  final String label;
  final String card;
  final String imagePath;

  const PaymentMethodCard({
    super.key,
    required this.title,
    required this.label,
    required this.card,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
     onTap: (){
       Navigator.pushNamed(context, AppRoutes.updatecard);
     },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.textFieldFill,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 7),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(imagePath),
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label,
                          style:
                          const TextStyle(fontWeight: FontWeight.bold)),
                      Text(card, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
