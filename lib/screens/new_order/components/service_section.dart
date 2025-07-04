import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laundromat/constants/app_assets.dart';
import 'package:laundromat/constants/app_colors.dart';
import 'package:laundromat/widgets/preference_button.dart';

class ServiceSection extends StatefulWidget {
  final String title;
  final List<Map<String, String>> items;
  final Map<String, int> itemCounts;
  final bool isAddBagChecked;
  final void Function(String itemName, int newCount) onQuantityChanged;
  final void Function(bool newValue)? onAddBagToggled;
  final VoidCallback? onPreferencePressed;
  final List<String> selectedPreferences;
  final String? selectedHeat;     // <-- Add this
  final String? selectedDry;      // <-- Add this
  final String selectedColor;
  final bool showCompactQuantity;


  const ServiceSection({
    super.key,
    required this.title,
    required this.items,
    required this.itemCounts,
    required this.onQuantityChanged,
    this.isAddBagChecked = false,
    this.onAddBagToggled,
    this.onPreferencePressed,
    this.selectedPreferences = const [],
    this.selectedHeat,           // <-- Add this
    this.selectedDry,
    required this.selectedColor,
    this.showCompactQuantity = false,
  });

  @override
  State<ServiceSection> createState() => _ServiceSectionState();
}

class _ServiceSectionState extends State<ServiceSection> {
  bool isExpanded = false;

  int get totalItems {
    return widget.itemCounts.entries.fold(0, (sum, entry) {
      if (entry.key == 'Add Bag') return sum;
      return sum + (entry.value);
    });
  }

  @override
  void initState() {
    super.initState();
    isExpanded = widget.title == 'Dry Cleaning';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isExpanded ? Border.all(color: AppColors.primary) : null,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isExpanded ? Colors.white : AppColors.border,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${widget.title} ($totalItems)",
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                          ),
                          AddPreferencesButton(
                            onPressed: widget.onPreferencePressed,
                          ),

                        ],
                      ),
                      if (widget.selectedPreferences.isNotEmpty ||
                          widget.selectedHeat != null ||
                          widget.selectedDry != null ||
                          widget.selectedColor.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              if (widget.selectedHeat != null)
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    chipTheme: ChipThemeData(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ),
                                  child: Chip(
                                    label: Text(" ${widget.selectedHeat}"),
                                    backgroundColor: AppColors.lightred,
                                    labelStyle: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              if (widget.selectedDry != null)
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    chipTheme: ChipThemeData(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ),
                                  child: Chip(
                                    label: Text(" ${widget.selectedDry}"),
                                    backgroundColor: AppColors.lightBlue,
                                    labelStyle: const TextStyle(color: AppColors.text),
                                  ),
                                ),
                              if (widget.selectedColor.isNotEmpty)
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    chipTheme: ChipThemeData(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ),
                                  child: Chip(
                                    label: Text("Color: ${widget.selectedColor}"),
                                    backgroundColor: AppColors.lightBlue,
                                    labelStyle: const TextStyle(color: AppColors.text),
                                  ),
                                ),
                              ...widget.selectedPreferences.map((p) => Theme(
                                data: Theme.of(context).copyWith(
                                  chipTheme: ChipThemeData(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ),
                                child: Chip(
                                  label: Text(p),
                                  backgroundColor: AppColors.lightGreen,
                                  labelStyle: const TextStyle(color: AppColors.text),
                                ),
                              )),

                            ],
                          ),
                        ),


                    ],
                  ),
                ),
                if (isExpanded)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Divider(thickness: 1, height: 1),
                  ),
              ],
            ),
          ),
          if (isExpanded)
            ...widget.items.asMap().entries.map((entry) {
              final item = entry.value;
              final name = item['name'] ?? '';
              final image = item['image'] ?? '';
              final isAddBag = name == 'Add Bag';
              final currentCount = widget.itemCounts[name] ?? (isAddBag ? 0 : 1);

              return Column(
                children: [
                  Container(
                    decoration: isAddBag
                        ? const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFFFDF00), Color(0xFFFDBCD0)],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(11),
                        bottomRight: Radius.circular(11),
                      ),
                    )
                        : const BoxDecoration(color: Colors.white),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    child: Row(
                      children: [
                        isAddBag
                            ? GestureDetector(
                          onTap: () {
                            if (widget.onAddBagToggled != null) {
                              widget.onAddBagToggled!(!widget.isAddBagChecked);
                            }
                          },
                          child: SizedBox(
                            width: 50,
                            child: Center(
                              child: Icon(
                                widget.isAddBagChecked
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(image, height: 50, width: 50, fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          flex: 4,
                          child: Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        if (!isAddBag || widget.isAddBagChecked)
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("Quantity"),
                              ),
                              GestureDetector(
                                onTap: () {
                                  final newCount = (currentCount - 1).clamp(0, 999);
                                  widget.onQuantityChanged(name, newCount);
                                },
                                child: SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: SvgPicture.asset(AppAssets.removeQuantity),
                                ),
                              ),
                              Container(
                                width: 30,
                                height: 32,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.textFieldFill,
                                ),
                                child: Text(
                                  '$currentCount',
                                  style: const TextStyle(
                                    color: AppColors.text,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  final newCount = currentCount + 1;
                                  widget.onQuantityChanged(name, newCount);
                                },
                                child: SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: SvgPicture.asset(AppAssets.addQuantity),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  if (entry.key != widget.items.length - 1)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Divider(height: 1, thickness: 1),
                    ),
                ],
              );
            }).toList(),
        ],
      ),
    );
  }
}