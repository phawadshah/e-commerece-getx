import 'package:flutter/material.dart';
import 'package:shop/app/modules/base/widgets/nav_bar_item.dart';

class NavigationBarWigdet extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final int cartCount;

  const NavigationBarWigdet({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.cartCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
      padding: const EdgeInsetsDirectional.only(
        top: 0,
        start: 20,
        end: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NavBarItem(
            icon: unselectedIcons[0],
            activeIcon: selectedIcons[0],
            active: currentIndex == 0,
            label: "Home",
            onTap: () {
              onTap(0);
            },
          ),
          NavBarItem(
            icon: unselectedIcons[1],
            activeIcon: selectedIcons[1],
            active: currentIndex == 1,
            label: "Search",
            onTap: () {
              onTap(1);
            },
          ),
          NavBarItem(
            icon: unselectedIcons[2],
            activeIcon: selectedIcons[2],
            active: currentIndex == 2,
            label: "Categories",
            onTap: () {
              onTap(2);
            },
          ),
          NavBarItem(
            icon: cartCount == 0
                ? unselectedIcons[3]
                : Badge.count(
                    count: cartCount,
                    child: unselectedIcons[3],
                  ),
            activeIcon: cartCount == 0
                ? selectedIcons[3]
                : Badge.count(
                    count: cartCount,
                    child: selectedIcons[3],
                  ),
            active: currentIndex == 3,
            label: "Cart",
            onTap: () {
              onTap(3);
            },
          ),
        ],
      ),
    );
  }
}

final List<Widget> unselectedIcons = [
  const Icon(Icons.home, size: 24, color: Colors.black38),
  const Icon(Icons.search, size: 24, color: Colors.black38),
  const Icon(Icons.category, size: 24, color: Colors.black38),
  const Icon(Icons.shopping_cart, size: 24, color: Colors.black38),
];

final List<Widget> selectedIcons = [
  const Icon(Icons.home, size: 26, color: Colors.blue),
  const Icon(Icons.search, size: 26, color: Colors.blue),
  const Icon(Icons.category, size: 26, color: Colors.blue),
  const Icon(Icons.shopping_cart, size: 26, color: Colors.blue),
];
