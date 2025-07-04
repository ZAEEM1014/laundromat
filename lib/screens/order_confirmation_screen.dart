import 'package:flutter/material.dart';
import 'package:laundromat/constants/app_colors.dart';
import 'package:laundromat/widgets/text_field.dart';
import '../data/laundry_data.dart';
import '../routes/routes.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/gradient_button.dart';
import '../widgets/preference_button.dart';

class OrderConfirmationScreen extends StatefulWidget {
  const OrderConfirmationScreen({super.key});

  @override
  State<OrderConfirmationScreen> createState() => _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  int _selectedIndex = 1;
  String selectedPaymentMethod = 'google';
  late Map<String, Map<String, int>> itemCounts;


  Map<String, int> sectionCounts = {
    'Dry Cleaning': 0,
    'Washing': 0,
    'Washing & Dry Cleaning': 0,
  };
  String laundryWeight = '0 lbs';
  double totalCost = 0.0;
  double pricePerPound = 2.25;
  bool isPickup = false;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final fullItemCounts = args?['itemCounts'] as Map<String, dynamic>?;

    itemCounts = fullItemCounts != null
        ? fullItemCounts.map((section, items) => MapEntry(section, Map<String, int>.from(items)))
        : generateInitialItemCounts(); // ✅ Safe fallback

    final sections = args?['sections'] as Map<String, int>?;
    final weightString = args?['weight'] ?? '0 lbs';
    isPickup = args?['isPickup'] ?? false;

    pricePerPound = isPickup ? 2.25 : 1.80;
    final numericWeight = double.tryParse(weightString.split(' ').first) ?? 0;

    setState(() {
      if (sections != null) {
        sectionCounts = sections;
      }
      laundryWeight = weightString;
      totalCost = numericWeight * pricePerPound;
    });
  }




  void _onNavTapped(int index) {
    setState(() => _selectedIndex = index);
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
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25),
                Text(
                  'Order Confirmation',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.text),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Row(
                      children: [
                        Text('Laundry Date : ',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: AppColors.text)),
                        Text(' 16-04-2025',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: AppColors.hintColor)),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Soap ID :',
                            style: TextStyle(color: AppColors.text, fontSize: 15)),
                        Text('#45336',
                            style: TextStyle(
                                color: AppColors.hintColor, fontSize: 15)),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                ...sectionCounts.entries.map(
                      (entry) => Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${entry.key} (${entry.value})',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 16),
                              ),
                              const SizedBox(width: 4),
                              IconButton(
                                icon: const Icon(Icons.edit, size: 16, color: AppColors.primary),
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.orderConfirmation,
                                    arguments: {
                                      'sections': sectionCounts,
                                      'weight': laundryWeight,
                                      'isPickup': isPickup,


                                      'itemCounts': itemCounts, // ✅ ADD THIS
                                    },
                                  );

                                },
                              ),


                            ],
                          ),
                          AddPreferencesButton(
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text("Let’s Talk Bubbles & Bucks",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: AppColors.text)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Laundry Load",
                        style: TextStyle(
                            color: AppColors.text,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                    Text('${laundryWeight.replaceAll('lbs', '').trim()} lbs',
                        style: TextStyle(
                            color: AppColors.text,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text("Per Pound ",
                            style: TextStyle(
                                color: AppColors.text,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                        Text(isPickup ? "(with Delivery)" : "(without Delivery)",
                            style: TextStyle(color: AppColors.hintColor)),
                      ],
                    ),
                    Text("\$${pricePerPound.toStringAsFixed(2)}",
                        style: TextStyle(
                            color: AppColors.text,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text("Grand Total ",
                            style: TextStyle(
                                color: AppColors.text,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                        const Text("(Freshness Included)",
                            style: TextStyle(color: AppColors.hintColor)),
                      ],
                    ),
                    Text("\$${totalCost.toStringAsFixed(2)}",
                        style: TextStyle(
                            color: AppColors.text,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 24),
                const Text("Got a Secret Soap Code?",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: AppColors.text)),
                const SizedBox(height: 8),
                CustomTextField(hintText: 'e.g. BUBBLES10'),
                const SizedBox(height: 24),
                const Text("Pay Your Way",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: AppColors.text)),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...['google', 'wallet', 'visa'].map((method) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: InkWell(
                        onTap: () => setState(() => selectedPaymentMethod = method),
                        child: Row(
                          children: [
                            Radio(
                              value: method,
                              groupValue: selectedPaymentMethod,
                              onChanged: (value) =>
                                  setState(() => selectedPaymentMethod = value.toString()),
                              activeColor: AppColors.text,
                              visualDensity:
                              VisualDensity(horizontal: -4, vertical: -4),
                              materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                            ),
                            SizedBox(width: 5),
                            Text(
                              method == 'google'
                                  ? 'Google Pay'
                                  : method == 'wallet'
                                  ? 'Wallet Payment'
                                  : 'Visa ************234',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Anything We Should Know?",
                    filled: true,
                    fillColor: AppColors.textFieldFill,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: GradientButton(
                    label: 'Make it Official',
                    onPressed: () {
                      bool orderSuccess = true; // simulate failed order

                      Navigator.pushNamed(
                        context,
                        orderSuccess ? AppRoutes.orderSuccess : AppRoutes.orderFailure,
                        arguments: {
                          'soapId': '45336',
                          'date': '10-05-2025',
                        },
                      );
                    },
                  ),
                )




              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
      ),
    );
  }
}
