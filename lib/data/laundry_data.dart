import 'package:laundromat/constants/app_assets.dart';

final List<String> sectionTitles = [
  'Dry Cleaning',
  'Wash and Fold',
  'Wash and Dry Clean',
];

final Map<String, List<Map<String, String>>> sectionItems = {
  'Dry Cleaning': [
    {'name': 'Crisp Tees', 'image': AppAssets.crispTees},
    {'name': 'Snazzy Jackets', 'image': AppAssets.snazzyJacket},
    {'name': 'Sock Revival', 'image': AppAssets.sockRevival},
    {'name': 'Sharp Shirts', 'image': AppAssets.sharpShirts},
    {'name': 'Add Bag', 'image': 'assets/images/add_bag.png'},
  ],
  'Wash and Fold': [
    {'name': 'Crisp Tees', 'image': AppAssets.crispTees},
    {'name': 'Snazzy Jackets', 'image': AppAssets.snazzyJacket},
    {'name': 'Sock Revival', 'image': AppAssets.sockRevival},
    {'name': 'Sharp Shirts', 'image': AppAssets.sharpShirts},
    {'name': 'Add Bag', 'image': 'assets/images/add_bag.png'},
  ],
  'Wash and Dry Clean': [
    {'name': 'Crisp Tees', 'image': AppAssets.crispTees},
    {'name': 'Snazzy Jackets', 'image': AppAssets.snazzyJacket},
    {'name': 'Sock Revival', 'image': AppAssets.sockRevival},
    {'name': 'Sharp Shirts', 'image': AppAssets.sharpShirts},
    {'name': 'Add Bag', 'image': 'assets/images/add_bag.png'},
  ],
};

Map<String, Map<String, int>> generateInitialItemCounts() {
  final Map<String, Map<String, int>> counts = {};
  for (final section in sectionItems.keys) {
    counts[section] = {};
    for (final item in sectionItems[section]!) {
      counts[section]![item['name']!] = 0;
    }
  }
  return counts;
}
