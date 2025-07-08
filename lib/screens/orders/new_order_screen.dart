import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laundromat/widgets/text_field.dart';
import '../../constants/app_colors.dart';
import '../../data/laundry_data.dart';
import '../../routes/routes.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/preference_sheet.dart';

import 'components/service_section.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  late Map<String, Map<String, int>> itemCounts;
  bool isAddBagChecked = false;
  bool isDeliverySelected = false;

  final TextEditingController addressController = TextEditingController();
  final TextEditingController dropOffController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  final FocusNode addressFocus = FocusNode();
  final FocusNode dropOffFocus = FocusNode();
  final FocusNode weightFocus = FocusNode();

  final ScrollController scrollController = ScrollController();

  final Map<String, String?> selectedHeats = {};
  final Map<String, String?> selectedDryLevels = {};
  final Map<String, List<String>> selectedInstructions = {};
  final Map<String, bool> rememberSelections = {};

  bool _showCustomSnackbar = false;
  String _snackbarMessage = '';

  @override
  void initState() {
    super.initState();
    itemCounts = generateInitialItemCounts();
    for (final section in sectionTitles) {
      selectedHeats[section] = null;
      selectedDryLevels[section] = null;
      selectedInstructions[section] = [];
      rememberSelections[section] = false;
    }
  }
  void showPreferenceSheet(String section) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => PreferencesSheet(
        title: section,
        defaultHeat: section == "Dry Cleaning" ? "Medium Heat" : null,
        onConfirm: ({
          required String? heat,
          required String? dry,
          required List<String> instructions,
          required bool remember,
        }) {
          setState(() {
            selectedHeats[section] = heat;
            selectedDryLevels[section] = dry;
            selectedInstructions[section] = instructions;
            rememberSelections[section] = remember;
          });
        },
      ),
    );
  }


  void showCustomSnackbar(String message) {
    setState(() {
      _showCustomSnackbar = true;
      _snackbarMessage = message;
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showCustomSnackbar = false;
        });
      }
    });
  }

  void showErrorAndFocus({
    required FocusNode focusNode,
    required double offset,
    required String message,
  }) {
    scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    focusNode.requestFocus();
    showCustomSnackbar(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_showCustomSnackbar)
              CustomSnackbar(message: _snackbarMessage),

            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Let's Get You Sparkly Clean!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      hintText: "e.g xyz street",
                      controller: addressController,
                      focusNode: addressFocus,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text(
                          "Delivery Location",
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.text,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          "Pickup",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Switch(
                          value: isDeliverySelected,
                          onChanged: (value) => setState(() => isDeliverySelected = value),
                          activeColor: Colors.white,
                          activeTrackColor: AppColors.primary,
                        ),
                      ],
                    ),
                    if (!isDeliverySelected)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: CustomTextField(
                          hintText: "Enter drop off location",
                          controller: dropOffController,
                          focusNode: dropOffFocus,
                        ),
                      ),
                    const SizedBox(height: 15),
                    const Text(
                      "Pick Your Magic Touch",
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.text,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...sectionTitles.map((section) {
                      return ServiceSection(
                        title: section,
                        items: sectionItems[section] ?? [],
                        itemCounts: itemCounts[section] ?? {},
                        isAddBagChecked: isAddBagChecked,
                        onAddBagToggled: (checked) => setState(() => isAddBagChecked = checked),
                        onQuantityChanged: (itemName, newCount) {
                          if (itemCounts[section] != null) {
                            setState(() => itemCounts[section]![itemName] = newCount);
                          }
                        },
                        onPreferencePressed: () => showPreferenceSheet(section),
                        selectedPreferences: selectedInstructions[section] ?? [],
                        selectedHeat: selectedHeats[section],
                        selectedDry: selectedDryLevels[section],
                        selectedColor: '',
                      );
                    }),
                    const SizedBox(height: 12),
                    const Text(
                      'How heavy’s your laundry haul?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      hintText: 'e.g. 50',
                      controller: weightController,
                      focusNode: weightFocus,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: GradientButton(
                        label: 'Make it Soapy!',
                        onPressed: () {
                          if (addressController.text.trim().isEmpty) {
                            showErrorAndFocus(
                              focusNode: addressFocus,
                              offset: 0,
                              message: 'Please enter your address.',
                            );
                            return;
                          }
                          if (!isDeliverySelected && dropOffController.text.trim().isEmpty) {
                            showErrorAndFocus(
                              focusNode: dropOffFocus,
                              offset: 180,
                              message: 'Please enter the drop-off location.',
                            );
                            return;
                          }
                          if (weightController.text.trim().isEmpty) {
                            showErrorAndFocus(
                              focusNode: weightFocus,
                              offset: 800,
                              message: 'Please enter the laundry weight.',
                            );
                            return;
                          }
                          final Map<String, int> sectionCounts = {};
                          for (final section in itemCounts.entries) {
                            final total = section.value.values.fold<int>(0, (sum, count) => sum + count);
                            sectionCounts[section.key] = total;
                          }
                          final String laundryWeight = weightController.text.trim();
                          Navigator.pushNamed(
                            context,
                            AppRoutes.orderConfirmation,
                            arguments: {
                              'sections': sectionCounts,
                              'weight': laundryWeight,
                              'isPickup': !isDeliverySelected,
                              'itemCounts': itemCounts,
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}