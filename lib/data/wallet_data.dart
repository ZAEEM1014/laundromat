import 'package:flutter/material.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';

class LedgerEntry {
  final String date;
  final String title;
  final String amount;
  final Color color;

  LedgerEntry({
    required this.date,
    required this.title,
    required this.amount,
    required this.color,
  });
}

final List<LedgerEntry> walletLedgerEntries = [
  LedgerEntry(date: "4-March-25", title: "Order#4587", amount: "\$69.99", color: AppColors.red),
  LedgerEntry(date: "01-March-25", title: "Top Up", amount: "\$250.00", color: Colors.green),
  LedgerEntry(date: "4-March-25", title: "Order#4587", amount: "\$779.99", color: AppColors.red),

  LedgerEntry(date: "01-March-25", title: "Top Up", amount: "\$24450.00", color: Colors.green),
  LedgerEntry(date: "4-March-25", title: "Order#4587", amount: "\$39.99", color: AppColors.red),
  LedgerEntry(date: "01-March-25", title: "Top Up", amount: "\$2250.00", color: Colors.green),
  LedgerEntry(date: "4-March-25", title: "Order#4587", amount: "\$69.99", color: AppColors.red),
  LedgerEntry(date: "01-March-25", title: "Top Up", amount: "\$50.00", color: Colors.green),
  LedgerEntry(date: "01-March-25", title: "Top Up", amount: "\$250.00", color: Colors.green),
  LedgerEntry(date: "4-March-25", title: "Order#4587", amount: "\$200.99", color: AppColors.red),
  LedgerEntry(date: "4-March-25", title: "Order#4587", amount: "\$89.99", color: AppColors.red),
];



final List<Map<String, String>> paymentMethods = [
  {
    'title':'Debit Card',
    'label': 'Personal',
    'card': 'Visa 0493',
    'image': AppAssets.profilePhoto,
  },
  {
    'title':'Cradit Card',
    'label': 'Business',
    'card': 'MasterCard 8831',
    'image': AppAssets.profilePhoto,
  },


  // Add more cards here
];
