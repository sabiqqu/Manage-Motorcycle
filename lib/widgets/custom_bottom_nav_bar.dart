import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/add_motorcycle_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  final RxInt currentIndex;

  CustomBottomNavBar({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex.value,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: [
        _buildNavItem('assets/bottonbar/home.jpg', 'Home', 0),
        _buildNavItem('assets/bottonbar/search.jpg', 'Search', 1),
        _buildAddNavItem(),
        _buildNavItem('assets/bottonbar/calendar-range.jpg', 'Schedule', 3),
        _buildNavItem('assets/bottonbar/user.jpg', 'Profile', 4),
      ],
      onTap: (index) {
        if (index == 2) {
          Get.to(() => AddMotorcycleScreen());
        } else {
          currentIndex.value = index;
          // Handle navigation for other tabs
          // ...
        }
      },
    ));
  }

  BottomNavigationBarItem _buildNavItem(String assetPath, String label, int index) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        assetPath,
        width: 24,
        height: 24,
        color: currentIndex.value == index ? Colors.blue : Colors.grey,
      ),
      label: label,
    );
  }

  BottomNavigationBarItem _buildAddNavItem() {
    return BottomNavigationBarItem(
      icon: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset(
          'assets/bottonbar/plus-square.jpg',
          width: 24,
          height: 24,
          color: Colors.white,
        ),
      ),
      label: '',
    );
  }
}
