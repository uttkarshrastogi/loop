import 'package:flutter/material.dart';
import '../../data/models/nav_item_model.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTap;
  final List<NavItemModel> items;

  const CustomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isActive = index == selectedIndex;
          return IconButton(
            onPressed: () => onItemTap(index),
            icon: Icon(
              items[index].icon,
              color: isActive ? Colors.white : Colors.grey[600],
            ),
          );
        }),
      ),
    );
  }
}
