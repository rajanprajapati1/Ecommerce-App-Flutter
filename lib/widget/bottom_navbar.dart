// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../controller/navbar_controller.dart';

class BottomNavbar extends StatelessWidget {
  final NavbarController controller = Get.find();

  BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedColor = theme.colorScheme.primary;
    final unselectedColor =
        theme.colorScheme.onSurface.withOpacity(0.8) ?? Colors.grey;

    return Obx(() => AnimatedSlide(
          duration: const Duration(milliseconds: 300),
          offset: controller.isVisible.value ? Offset.zero : const Offset(0, 1),
          curve: Curves.easeInOut,
          child: controller.isVisible.value
              ? AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: controller.isVisible.value ? 1 : 0,
                  curve: Curves.easeInOut,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 16,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    child: BottomNavigationBar(
                      currentIndex: controller.selectedIndex.value,
                      onTap: (index) {
                        if (index == 4) {
                          context.push('/cart');
                          return;
                        }
                        controller.setIndex(index);
                        switch (index) {
                          case 0:
                            context.go('/');
                            break;
                          case 1:
                            context.go('/picks');
                            break;
                          case 2:
                            context.go('/collection');
                            break;
                          case 3:
                            context.go('/trends');
                            break;
                        }
                      },
                      selectedItemColor: selectedColor,
                      unselectedItemColor: unselectedColor,
                      items: [
                        BottomNavigationBarItem(
                          icon: Image.asset(
                            'assets/images/home.png', // Replace with your image path
                            color: controller.selectedIndex.value == 0
                                ? selectedColor
                                : unselectedColor,
                            width: 24.0,
                            height: 24.0,
                          ),
                          activeIcon: Image.asset(
                            'assets/images/home_fill.png', // Replace with your image path
                            color: selectedColor,
                            width: 24.0,
                            height: 24.0,
                          ),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: HugeIcon(
                            icon: HugeIcons.strokeRoundedCards01,
                            color: controller.selectedIndex.value == 1
                                ? selectedColor
                                : unselectedColor,
                            size: 24.0,
                          ),
                          activeIcon: HugeIcon(
                            icon: HugeIcons.strokeRoundedCards01,
                            color: selectedColor,
                            size: 24.0,
                          ),
                          label: 'Picks',
                        ),
                        BottomNavigationBarItem(
                          icon: Image.asset(
                            'assets/images/grid_unfill.png', // Replace with your image path
                            color: controller.selectedIndex.value == 2
                                ? selectedColor
                                : unselectedColor,
                            width: 24.0,
                            height: 24.0,
                          ),
                          activeIcon: Image.asset(
                            'assets/images/grid_filled.png', // Replace with your image path
                            color: selectedColor,
                            width: 24.0,
                            height: 24.0,
                          ),
                          label: 'Collection',
                        ),
                        BottomNavigationBarItem(
                          icon: Image.asset(
                            'assets/images/like_new.png', // Replace with your image path
                            color: controller.selectedIndex.value == 3
                                ? selectedColor
                                : unselectedColor,
                            width: 24.0,
                            height: 24.0,
                          ),
                          activeIcon: Image.asset(
                            'assets/images/like_new_fill.png', // Replace with your image path
                            color: selectedColor,
                            width: 24.0,
                            height: 24.0,
                          ),
                          label: 'Trends',
                        ),
                        BottomNavigationBarItem(
                          icon: Image.asset(
                            'assets/images/bag_new.png', // Replace with your image path
                            color: controller.selectedIndex.value == 4
                                ? selectedColor
                                : unselectedColor,
                            width: 24.0,
                            height: 24.0,
                          ),
                          activeIcon: Image.asset(
                            'assets/images/bag_new.png', // Replace with your image path
                            color: selectedColor,
                            width: 24.0,
                            height: 24.0,
                          ),
                          label: 'Cart',
                        ),
                      ],
                      type: BottomNavigationBarType.fixed,
                    ),
                  ),
                )
              : const SizedBox.shrink(), // No space when hidden
        ));
  }
}
