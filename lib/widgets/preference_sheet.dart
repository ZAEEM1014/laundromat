import 'package:flutter/material.dart';
import 'package:laundromat/constants/constants.dart';
import 'package:laundromat/widgets/gradient_button.dart';

class PreferencesSheet extends StatefulWidget {
  final String title;
  final String? defaultHeat;

  final void Function({
  required String? heat,
  required String? dry,
  required List<String> instructions,
  required bool remember,
  }) onConfirm;

  const PreferencesSheet({
    super.key,
    required this.title,
    this.defaultHeat,
    required this.onConfirm,
  });

  @override
  State<PreferencesSheet> createState() => _PreferencesSheetState();
}

class _PreferencesSheetState extends State<PreferencesSheet> {
  String? selectedHeat;
  String? selectedDry;
  String? selectedInstruction;
  String selectedColor = '';
  bool remember = false;

  final heatOptions = ['Low Heat', 'Medium Heat', 'High Heat'];
  final dryOptions = ['Delicate', 'Extra Dry', 'Hang Dry'];
  final specialInstructions = [
    'Hanger', 'Folded', 'Boxed',
    'Light Starch', 'Starch', 'No Starch',
  ];
  final colorOptions = ['White', 'Black', 'Mixed'];

  @override
  void initState() {
    super.initState();
    if (widget.defaultHeat != null) {
      selectedHeat = widget.defaultHeat;
    }
    selectedDry = 'Delicate';
    selectedInstruction = 'Hanger';
    selectedHeat = 'Medium Heat';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.title} Preferences",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 12),

            /// Heat Level
            SingleChoiceChipGroup(
              title: "Heat Level",
              options: heatOptions,
              selectedOption: selectedHeat,
              onSelected: (val) => setState(() => selectedHeat = val),
            ),

            /// Dry Level
            SingleChoiceChipGroup(
              title: "Dry Level",
              options: dryOptions,
              selectedOption: selectedDry,
              onSelected: (val) => setState(() => selectedDry = val),
            ),

            /// Remember toggle
            Row(
              children: [
                Checkbox(
                  value: remember,
                  onChanged: (val) => setState(() => remember = val ?? false),
                ),
                const Expanded(
                  child: Text("Remember my laundry love for next time"),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// Color selection (shown but NOT returned)
            const Text("Choose Colors", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: colorOptions.map((color) {
                final isSelected = selectedColor == color;
                final BoxDecoration boxDecoration;

                if (color == 'White') {
                  boxDecoration = BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                      width: 2,
                    ),
                  );
                } else if (color == 'Black') {
                  boxDecoration = BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                      width: 2,
                    ),
                  );
                } else {
                  boxDecoration = BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFC84C4C),
                        Color(0xFFFFDA60),
                        Color(0xFF0FBC5F),
                        Color(0xFFDADADA),
                      ],
                      stops: [0.0, 0.5, 0.75, 1.0],
                    ),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                      width: 2,
                    ),
                  );
                }

                return GestureDetector(
                  onTap: () => setState(() => selectedColor = color),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      children: [
                        Container(width: 40, height: 40, decoration: boxDecoration),
                        const SizedBox(height: 4),
                        Text(color),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            /// Special Instructions
            SingleChoiceChipGroup(
              title: "Preferences + Special Instructions",
              options: specialInstructions,
              selectedOption: selectedInstruction,
              onSelected: (val) => setState(() => selectedInstruction = val),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: GradientButton(
                label: 'Make it Official',
                onPressed: () {
                  widget.onConfirm(
                    heat: selectedHeat,
                    dry: selectedDry,
                    instructions: selectedInstruction != null ? [selectedInstruction!] : [],
                    remember: remember,
                  );
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SingleChoiceChipGroup extends StatelessWidget {
  final String title;
  final List<String> options;
  final String? selectedOption;
  final ValueChanged<String?> onSelected;

  const SingleChoiceChipGroup({
    super.key,
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final isSelected = selectedOption == option;
            return SizedBox(
              width: 100,
              height: 60,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 100),
                child: ChoiceChip(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  label: Text(option),
                  selected: isSelected,
                  showCheckmark: false,
                  onSelected: (_) => onSelected(isSelected ? null : option),
                  selectedColor: AppColors.lightBlue,
                  backgroundColor: AppColors.textFieldFill,
                  side: BorderSide(color: isSelected ? AppColors.primary : AppColors.border),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: isSelected ? AppColors.primary : AppColors.text,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
