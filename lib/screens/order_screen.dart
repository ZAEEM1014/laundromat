import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with TickerProviderStateMixin {
  late TabController _tabController;

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabLabels.length, vsync: this);
  }

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
        statusColor =AppColors.lightred;
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
    return Column(
      children: [
        const SizedBox(height: 15),

        // TabBar
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.lightBlue,
            border: Border.all(color: AppColors.primary, width: 1),
            borderRadius: BorderRadius.circular(31),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(31),
            ),

            labelColor: Colors.white,
            unselectedLabelColor: AppColors.text,

            labelStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
            unselectedLabelStyle: const TextStyle(fontSize:13,fontWeight: FontWeight.w600),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: tabLabels.map((label) => Tab(text: label)).toList(),
          ),
        ),

        const SizedBox(height: 10),

        // Tab Views
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: tabLabels.map((label) {
              final filtered = _filterOrders(label);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$label Orders",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 5),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (_, index) => _buildOrderItem(filtered[index]),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
