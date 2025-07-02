import 'package:flutter/material.dart';
import 'package:laundromat/constants/constants.dart';
import 'package:laundromat/widgets/primary_button.dart';
import 'package:laundromat/widgets/text_field.dart';
import '../widgets/custom_navbar.dart';

class OrderDetailScreen extends StatefulWidget {
  final String date;
  final String soapId;
  final String email;
  final int currentStep;

  const OrderDetailScreen({
    super.key,
    required this.date,
    required this.soapId,
    required this.email,
    required this.currentStep,
  });

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int _selectedIndex = 1;

  final List<String> stepTitles = [
    'Order Placed',
    'Collected',
    'Washing',
    'Pressing',
    'Out for Delivery',
    'Delivered',
  ];

  final List<String> stepImages = [
    'assets/images/order_placed.png',
    'assets/images/order_collected.png',
    'assets/images/order_washing.png',
    'assets/images/order_processing.png',
    'assets/images/order_out_for_deliver.png',
    'assets/images/order_delivered.png',
  ];

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
    int safeStep = widget.currentStep.clamp(0, stepImages.length - 1);

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
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12, top: 10, bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Color(0xFFFFE7A7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Out For Delivery',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text("Date: ",
                        style: TextStyle(
                            color: AppColors.text,
                            fontWeight: FontWeight.w600,
                            fontSize: 15)),
                    Text(" ${widget.date}",
                        style: const TextStyle(
                            color: AppColors.hintColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 15)),
                  ],
                ),
                Row(
                  children: [
                    const Text("Soap ID: ",
                        style: TextStyle(
                            color: AppColors.text,
                            fontWeight: FontWeight.w600,
                            fontSize: 15)),
                    Text(" #${widget.soapId}",
                        style: const TextStyle(
                            color: AppColors.hintColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 15)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text("Email",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
            const SizedBox(height: 4),
            CustomTextField(hintText: widget.email),
            const SizedBox(height: 16),
            const Text("Track Order",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),

            Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Image.asset(
                  stepImages[safeStep],
                  key: ValueKey(stepImages[safeStep]),
                  height: 204,
                  width: 226,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: AnimatedSwitcher(
                duration: const Duration(seconds: 5),
                transitionBuilder: (child, animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 0.5),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
                child: Text(
                  "Step ${safeStep + 1}:\n${stepTitles[safeStep]}",
                  key: ValueKey(stepTitles[safeStep]),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            OrderProgressBar(currentStep: safeStep),
            const SizedBox(height: 10),
            const Text(
              "Your laundry’s getting its final fluff — almost at your doorstep!",
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.text, fontSize: 15),
            ),
           Spacer(),

            Center(
              child: PrimaryButton(
                label: 'Get Your Bubble Bill',
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 16),
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

class OrderProgressBar extends StatefulWidget {
  final int currentStep;

  const OrderProgressBar({super.key, required this.currentStep});

  @override
  State<OrderProgressBar> createState() => _OrderProgressBarState();
}

class _OrderProgressBarState extends State<OrderProgressBar> {
  late double progressWidth;
  final steps = ['Order placed', 'Collected', 'Washing', 'Pressing', 'Delivered'];

  @override
  void didUpdateWidget(covariant OrderProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentStep != widget.currentStep) {
      setState(() {}); // triggers animation when step changes
    }
  }

  @override
  Widget build(BuildContext context) {
    double barWidth = MediaQuery.of(context).size.width - 40;

    return Column(
      children: [
        SizedBox(
          width: barWidth,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              // Background bar
              Container(
                height: 10.28,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(
                    color: AppColors.primary,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              // Animated filling bar
              AnimatedContainer(
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeInOut,
                height: 10.28,
                width: (barWidth * ((widget.currentStep + 0.4) / (steps.length - 1))).clamp(0, barWidth),

                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              // Progress circles
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(steps.length, (index) {
                  final isActive = index <= widget.currentStep;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    width: 26.097,
                    height: 26.097,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive ? AppColors.primary : Colors.white,
                      border: Border.all(
                        color: AppColors.primary,
                        width: 1,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: barWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(steps.length, (index) {
              return SizedBox(
                width: 48,
                child: Text(
                  steps[index],
                  style: TextStyle(
                    fontSize: 10,
                    color: index == widget.currentStep
                        ? AppColors.primary
                        : AppColors.text,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}


