import 'package:flutter/material.dart';
import 'package:laundromat/constants/app_assets.dart';
import 'package:laundromat/constants/app_colors.dart';

class ServiceSectionBilling extends StatefulWidget {
  final String title;
  final List<Map<String, String>> items;
  final Map<String, int> itemCounts;
  final bool isAddBagChecked;
  final void Function(String itemName, int newCount) onQuantityChanged;
  final void Function(bool newValue)? onAddBagToggled;
  final String? selectedHeat;
  final String? selectedDry;
  final String selectedColor;
  final bool showCompactQuantity;
  final List<String> selectedPreferences;

  const ServiceSectionBilling({
    super.key,
    required this.title,
    required this.items,
    required this.itemCounts,
    required this.onQuantityChanged,
    this.isAddBagChecked = false,
    this.onAddBagToggled,
    this.selectedHeat,
    this.selectedDry,
    required this.selectedColor,
    this.showCompactQuantity = false,
    this.selectedPreferences = const [],
  });

  @override
  State<ServiceSectionBilling> createState() => _ServiceSectionBillingState();
}

class _ServiceSectionBillingState extends State<ServiceSectionBilling> {
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
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isExpanded ? Colors.white : AppColors.border,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.title} ($totalItems)",
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Divider(thickness: 1, height: 1),
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
                            ? const Icon(Icons.error_outline, size: 24, color: Colors.black)
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(image, height: 50, width: 50, fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          flex: 4,
                          child: Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
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
