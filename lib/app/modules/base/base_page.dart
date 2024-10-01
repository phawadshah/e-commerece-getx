import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import 'base_controller.dart';
import 'widgets/navigation_widget.dart';

class BasePage extends GetView<BaseController> {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PersistentTabView.custom(
        context,
        hideNavigationBarWhenKeyboardAppears: false,
        resizeToAvoidBottomInset: false,
        itemCount: 5,
        controller: controller.tabController,
        screens: controller.navBarScreens,
        customWidget: Obx(
          () => NavigationBarWigdet(
            cartCount: controller.cartCount.value,
            currentIndex: controller.currentIndex,
            onTap: controller.changeTab,
          ),
        ),
      ),
    );
  }
}


/* 
  Obx(
        () => IndexedStack(
          index: controller.currentIndex,
          children: controller.pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          onTap: controller.changeTab,
          currentIndex: controller.currentIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black38,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: controller.cartCount.value > 0
                  ? Badge.count(
                      count: controller.cartCount.value,
                      textStyle: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.shopping_cart),
                    )
                  : const Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    
*/