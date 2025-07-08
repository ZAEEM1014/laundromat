import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../widgets/custom_appBar.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/custom_navbar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  int _selectedIndex = 0;

  final TextEditingController _nameController =
  TextEditingController(text: 'Leslie Alexander');
  final TextEditingController _emailController =
  TextEditingController(text: 'LeslieAlexander@email.com');
  final TextEditingController _phoneController =
  TextEditingController(text: '+61-452-477-1');
  final TextEditingController _dobController =
  TextEditingController(text: '22-oct-1996');

  bool _isNameEditable = false;
  bool _isEmailEditable = false;
  bool _isPhoneEditable = false;
  bool _isDobEditable = false;

  String _customerType = 'User Personal';
  String _userName = 'Leslie Alexander';

  void _onNavTapped(int index) {
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
      appBar: const CustomAppBar(),
      drawer: CustomDrawer(
        onEditProfile: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const EditProfileScreen()),
          );
        },
        onSignOut: () {
          // Sign-out logic
        },
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage:
                  AssetImage(AppAssets.profilePhoto),
                ),
                const SizedBox(height: 10),
                Text(
                  _userName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const Text(
                  'Update Profile Picture',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildLabelWithEdit("User Name", () => setState(() => _isNameEditable = true)),
            _buildTextField(_nameController, _isNameEditable),
            _buildLabelWithEdit("Customer Category", null),
            _buildDropdown(),
            _buildLabelWithEdit("Email", () => setState(() => _isEmailEditable = true)),
            _buildTextField(_emailController, _isEmailEditable),
            _buildLabelWithEdit("Phone Number", () => setState(() => _isPhoneEditable = true)),
            _buildTextField(_phoneController, _isPhoneEditable),
            _buildLabelWithEdit("Date of Birth", () => setState(() => _isDobEditable = true)),
            _buildTextField(_dobController, _isDobEditable),

            _buildAddressSection(),
            const SizedBox(height: 10),
            _buildAddressSaveButton(),
            const SizedBox(height: 20),
            _buildGradientSaveButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
      ),
    );
  }

  Widget _buildLabelWithEdit(String label, VoidCallback? onEdit) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const Spacer(),
          if (onEdit != null)
            GestureDetector(
              onTap: onEdit,
             child:  SvgPicture.asset(
               AppAssets.edit,
               height: 20,
               width: 20,
               // Optional: applies tint
             ),

    ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, bool enabled) {
    return TextField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.textFieldFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.textFieldFill,
        borderRadius: BorderRadius.circular(30),
      ),
      child: DropdownButton<String>(
        value: _customerType,
        underline: const SizedBox(),
        borderRadius: BorderRadius.circular(20),
        isExpanded: true,
        items: const [
          DropdownMenuItem(
              value: 'User Personal', child: Text('User Personal')),
          DropdownMenuItem(value: 'Business', child: Text('Business')),
        ],
        onChanged: (value) {
          setState(() {
            _customerType = value!;
          });
        },
      ),
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16, bottom: 8),
          child: Text(
            "Address",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Wrap(
          spacing: 10,
          children: [
            ActionChip(
              label: const Text("Home"),
              backgroundColor: AppColors.lightGreen,
              onPressed: () {
                // Handle adding new location
              },
            ),
            ActionChip(
              label: const Text("Office"),
              backgroundColor: AppColors.lightBlue,
              onPressed: () {
                // Handle adding new location
              },
            ),
            ActionChip(
              label: const Text("Add new location"),
              backgroundColor: AppColors.lightred,
              onPressed: () {
                // Handle adding new location
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: _buildHintTextField('House no')),
            const SizedBox(width: 10),
            Expanded(child: _buildHintTextField('Street')),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: _buildHintTextField('Town')),
            const SizedBox(width: 10),
            Expanded(child: _buildHintTextField('City')),
          ],
        ),
      ],
    );
  }

  Widget _buildHintTextField(String hintText) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppColors.border, // from your constants
        ),
        filled: true,
        fillColor: AppColors.textFieldFill,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }



  Widget _buildAddressSaveButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      height: 34,
      decoration: BoxDecoration(

        color: AppColors.primary
      ),
      child: InkWell(

        onTap: () {
          // TODO: Save logic
        },
        child: const Center(
          child: Text(
            'Save',
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildGradientSaveButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      height: 53,
      decoration: BoxDecoration(

        gradient: const LinearGradient(
          colors: [Color(0xFFFFEB3B), Color(0xFFF8BBD0)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: InkWell(

        onTap: () {
          // TODO: Save logic
        },
        child: const Center(
          child: Text(
            'Save',
            style: TextStyle(
              color: AppColors.text,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
