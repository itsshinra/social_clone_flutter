// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../posts/views/home_screen.dart';
import '../views/screens/menu_screen.dart';

class MainController extends GetxController {
  final box = GetStorage();
  int selectedIndex = 0;

  final screens = [
    const HomeScreen(),
    Container(child: const Center(child: Text('Reels Screen'))),
    Container(child: const Center(child: Text('Friends Screen'))),
    Container(child: const Center(child: Text('Notifications Screen'))),
    const MenuScreen(),
  ];
  void onItemTapped(int index) {
    selectedIndex = index;
    update(['index_sctack', 'bottom_navigation_bar']);
  }

  void logout() async {
    await box.remove("token");

    Get.offAllNamed('/login');
    Get.snackbar(
      'Success',
      'User logged out successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}