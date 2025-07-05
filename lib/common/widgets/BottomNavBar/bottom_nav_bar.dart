import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onIconPressed;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    const active = Color(0xFFFFFFFF);
    const inactive = Color(0xFF707B81);

    return Container(
      color: Colors.black,
      padding: const EdgeInsets.only(bottom: 20, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(
              Iconsax.home4,
              size: 26,
              color: selectedIndex == 0 ? active : inactive,
            ),
            onPressed: () => onIconPressed(0),
          ),
          IconButton(
            icon: Icon(
              Iconsax.route_square,
              size: 26,
              color: selectedIndex == 1 ? active : inactive,
            ),
            onPressed: () => onIconPressed(1),
          ),
          IconButton(
            icon: Icon(
              Iconsax.notification_bing,
              size: 26,
              color: selectedIndex == 2 ? active : inactive,
            ),
            onPressed: () => onIconPressed(2),
          ),
          IconButton(
            icon: Icon(
              Iconsax.user,
              size: 26,
              color: selectedIndex == 3 ? active : inactive,
            ),
            onPressed: () => onIconPressed(3),
          ),
        ],
      ),
    );
  }
}
