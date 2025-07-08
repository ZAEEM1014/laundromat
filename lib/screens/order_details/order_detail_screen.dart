import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class OrdersDetailScreen extends StatefulWidget {
  const OrdersDetailScreen({super.key});

  @override
  State<OrdersDetailScreen> createState() => _OrdersDetailScreenState();
}

class _OrdersDetailScreenState extends State<OrdersDetailScreen> {
  int selectedIndex = 0;

  final List<String> tabLabels = ["All", "Delivered", "In Process", "Cancelled"];

  final List<Map<String, String>> orders = List.generate(
    10,
        (index) => {
      "id": "#12345${index + 1}",
      "amount": "${(50 + index * 5).toStringAsFixed(2)}\$",
      "date": "25-may-2025",
      "status": ["delivered", "in process", "cancelled"][index % 3],
    },
  );

  List<Map<String, String>> _filterOrders(String status) {
    if (status == "All") return orders;
    return orders.where((order) => order['status'] == status.toLowerCase()).toList();
  }

  Widget _buildOrderItem(Map<String, String> order) {
    Color statusColor;
    switch (order['status']) {
      case 'delivered':
        statusColor = AppColors.lightGreen;
        break;
      case 'in process':
        statusColor = AppColors.lightBlue;
        break;
      case 'cancelled':
        statusColor = AppColors.lightred;
        break;
      default:
        statusColor = Colors.grey.shade300;
    }

    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 0),
          title: Text('Order ID ${order["id"]}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(order["amount"]!),
              Text(order["date"]!),
            ],
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              order['status']!,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final String selectedTabLabel = tabLabels[selectedIndex];

    return Column(
      children: [
        const SizedBox(height: 15),

        /// ✅ Full-width custom pill-style tab bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.primary),
            ),
            child: Row(
              children: List.generate(tabLabels.length, (index) {
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? AppColors.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        tabLabels[index],
                        style: TextStyle(
                          color: selectedIndex == index
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),

        const SizedBox(height: 20),

        /// ✅ Header Text matching tab
        Text(
          "$selectedTabLabel Orders",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.text,
          ),
        ),

        const SizedBox(height: 10),

        /// ✅ List of orders
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              itemCount: _filterOrders(selectedTabLabel).length,
              itemBuilder: (_, index) {
                return _buildOrderItem(_filterOrders(selectedTabLabel)[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
}
