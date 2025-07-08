import 'package:flutter/material.dart';
import 'package:laundromat/routes/routes.dart';
import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Fixed Wallet Balance Bar
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, AppRoutes.wallethome);
            },
            child: Container(

              height: 50,

              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              width: double.infinity,
              color: AppColors.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Wallet Balance", style: TextStyle(color: AppColors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                  Text("\$103", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20)),
                ],
              ),
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Status Cards Grid
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      statusCard("Total Deliveries", "10", AppAssets.totalDelivery, AppColors.lightBlue),
                      statusCard("Pickup Requests", "35", AppAssets.pickupRequest, AppColors.lightYellow),
                      statusCard("In Process", "50", AppAssets.progress, AppColors.textFieldFill),
                      statusCard("Delivered", "05", AppAssets.delivered, AppColors.lightGreen),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Orders List Header
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Current Orders", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                  ),
                  const SizedBox(height: 10),

                  // Sample Orders
                  orderTile("Order ID #12345", "80.65\$", "Ready for Pickup", AppColors.lightGreen),
                  Divider(),
                  orderTile("Order ID #12345", "80.65\$", "Out for Delivery", AppColors.lightYellow),
                  Divider(),
                  orderTile("Order ID #45678", "70.01\$", "Waiting", AppColors.lightBlue),
                  Divider(),
                  orderTile("Order ID #45678", "70.01\$", "Delivered", AppColors.lightGreen),
                  Divider(),
                  orderTile("Order ID #45678", "70.01\$", "Waiting", AppColors.lightBlue),
                  Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Status Card Widget
  Widget statusCard(String title, String count, String assetPath, Color bgColor) {
    return Container(

      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(assetPath, height: 65,width: 55,),
          const SizedBox(height: 8),
          Text(title,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
          const SizedBox(height: 4),
          Text(count, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Order Tile Widget
  Widget orderTile(String id, String price, String status, Color statusColor) {
    return Container(

      margin: const EdgeInsets.symmetric(vertical: 0),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(id, style: const TextStyle(fontSize:12,fontWeight: FontWeight.w500)),
              const SizedBox(height: 2),
              Text(price,style: const TextStyle(fontSize:12,fontWeight: FontWeight.w400)),
            ],
          ),
          Container(
            constraints: const BoxConstraints(minWidth: 120), // uniform width
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), // spacing
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Text(
              status,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),

        ],
      ),
    );

  }
}
