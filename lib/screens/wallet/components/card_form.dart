import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../widgets/gradient_button.dart';



class CardForm extends StatefulWidget {
  final String? card1;
  final String? card2;
  final String? card3;
  final String? card4;
  final String? month;
  final String? year;

  final VoidCallback onSave;

  const CardForm({
    super.key,
    this.card1,
    this.card2,
    this.card3,
    this.card4,
    this.month,
    this.year,

    required this.onSave,
  });

  @override
  State<CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {
  late final TextEditingController card1Ctrl;
  late final TextEditingController card2Ctrl;
  late final TextEditingController card3Ctrl;
  late final TextEditingController card4Ctrl;
  late final TextEditingController monthCtrl;
  late final TextEditingController yearCtrl;
  late final TextEditingController labelMonthCtrl;

  @override
  void initState() {
    super.initState();
    card1Ctrl = TextEditingController(text: widget.card1 ?? '');
    card2Ctrl = TextEditingController(text: widget.card2 ?? '');
    card3Ctrl = TextEditingController(text: widget.card3 ?? '');
    card4Ctrl = TextEditingController(text: widget.card4 ?? '');
    monthCtrl = TextEditingController(text: widget.month ?? '');
    yearCtrl = TextEditingController(text: widget.year ?? '');
    labelMonthCtrl = TextEditingController(text: 'June');
  }


  @override
  void dispose() {
    card1Ctrl.dispose();
    card2Ctrl.dispose();
    card3Ctrl.dispose();
    card4Ctrl.dispose();
    monthCtrl.dispose();
    yearCtrl.dispose();
    labelMonthCtrl.dispose();
    super.dispose();
  }

  InputDecoration fieldDecoration() => InputDecoration(
    isDense: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: BorderSide(color: AppColors.border, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: const BorderSide(color: AppColors.primary, width: 1),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.textFieldFill,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Card Number",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCardBox(card1Ctrl),
              _buildCardBox(card2Ctrl),
              _buildCardBox(card3Ctrl),
              _buildCardBox(card4Ctrl),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              _buildColumnField("Select Month", monthCtrl),
              const SizedBox(width: 16),
              _buildColumnField("Select Year", yearCtrl),
            ],
          ),
          const SizedBox(height: 5),
          const Text("Select Month",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text)),
          const SizedBox(height: 4),
          TextFormField(
            controller: labelMonthCtrl,
            decoration: fieldDecoration(),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: GradientButton(
              label: 'Save Card',
              onPressed: widget.onSave,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardBox(TextEditingController ctrl) {
    return SizedBox(
      width: 60,
      child: TextFormField(
        controller: ctrl,
        decoration: fieldDecoration(),
      ),
    );
  }

  Widget _buildColumnField(String label, TextEditingController ctrl) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text)),
          const SizedBox(height: 4),
          TextFormField(
            controller: ctrl,
            decoration: fieldDecoration(),
          ),
        ],
      ),
    );
  }
}
