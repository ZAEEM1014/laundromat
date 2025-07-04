import 'package:flutter/material.dart';
import 'package:laundromat/constants/app_colors.dart';
import 'package:laundromat/widgets/gradient_button.dart';
import 'package:laundromat/widgets/primary_button.dart';
import 'package:laundromat/screens/order_billing/components/service_section_billing.dart';
import 'package:laundromat/data/laundry_data.dart';

class OrderBillScreen extends StatefulWidget {
  final double laundryWeight;
  final double pricePerPound;
  final double totalPrice;
  final String date;
  final String soapId;

  const OrderBillScreen({
    super.key,
    required this.laundryWeight,
    required this.pricePerPound,
    required this.totalPrice,
    required this.date,
    required this.soapId,
  });

  @override
  State<OrderBillScreen> createState() => _OrderBillScreenState();
}

class _OrderBillScreenState extends State<OrderBillScreen> {
  late Map<String, Map<String, int>> itemCounts;

  @override
  void initState() {
    super.initState();
    // In future, replace this with data from your database
    itemCounts = generateInitialItemCounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: const BackButton(color: AppColors.text),
        title: const Text(
          'Order Detail',
          style: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children:  [
              Text("Date: ",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: AppColors.text)),
              Text(
                widget.date,
                style: TextStyle(
                    color: AppColors.hintColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 15),
              ),
              Spacer(),
              Text("Soap ID: ",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: AppColors.text)),
              Text(
                "#${widget.soapId}",
                style: TextStyle(
                    color: AppColors.hintColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 15),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Service Sections
          ...sectionTitles.map((section) => ServiceSectionBilling(
            title: section,
            items: sectionItems[section]!,
            itemCounts: itemCounts[section]!,
            onQuantityChanged: (item, count) {
              setState(() {
                itemCounts[section]![item] = count;
              });
            },
            isAddBagChecked: itemCounts[section]!['Add Bag'] != 0,
            onAddBagToggled: (newValue) {
              setState(() {
                itemCounts[section]!['Add Bag'] = newValue ? 1 : 0;
              });
            },
            selectedPreferences: const [],
            selectedHeat: null,
            selectedDry: null,
            selectedColor: '',
            showCompactQuantity: false,
          )),

          const SizedBox(height: 20),
          const Text(
            "Let’s Talk Bubbles & Bucks",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

                  const Text("Laundry Load: ",
                      style: TextStyle(
                          color: AppColors.text,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),


              Text(" ${widget.laundryWeight} lbs",
                  style: TextStyle(
                      color: AppColors.text,
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              const Text("Per Pound:",
                  style: TextStyle(
                      color: AppColors.text,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),


              Text(" \$${widget.pricePerPound}",
                  style: TextStyle(
                      color: AppColors.text,
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              const Text("Grand Total:",
                  style: TextStyle(
                      color: AppColors.text,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),


              Text("\$${widget.totalPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                      color: AppColors.text,
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
            ],
          ),




          const SizedBox(height: 20),
          const Text(
            "Anything We Should Know?",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.textFieldFill,
              borderRadius: BorderRadius.circular(10),
            ),
            child:  TextField(
              maxLines: null, // Allows multiline input
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: "Please remove any luxury/hands-dried. Last time, my shirt went in Charlie’s order not mine. Clarification. Let's reduce the clothes together.",
                hintStyle: TextStyle(fontSize: 13, color: AppColors.text),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),

          ),

          const SizedBox(height: 20),
          const Text(
            "Pay Your Way",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet_outlined),
            title: const Text("Google Pay"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.wallet),
            title: const Text("Wallet Balance"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.credit_card),
            title: const Text("Visa **** 1234"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          const SizedBox(height: 20),
          GradientButton(
            label: "Get Your Bubble Bill ",
            onPressed: () {},
          ),
          const SizedBox(height: 12),
          PrimaryButton(
            label: "Return To Order List",
            onPressed: () {},
            fontSize: 18,
            color: AppColors.primary,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
