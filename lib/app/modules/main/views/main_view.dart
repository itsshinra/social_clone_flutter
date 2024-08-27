import 'package:facebook_clone_app/app/modules/main/controllers/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  // List of widgets for each screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MainController>(
        init: MainController(),
        id: 'index_sctack',
        builder: (_) {
          return IndexedStack(
            index: controller.selectedIndex,
            children: controller.screens,
          );
        },
      ),
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  Widget _bottomNavBar() {
    return GetBuilder<MainController>(
      init: MainController(),
      id: 'bottom_navigation_bar',
      builder: (_) {
        return BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: controller.selectedIndex,
          onTap: controller.onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey.shade800,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          items: const [
            BottomNavigationBarItem(icon: Icon(Iconsax.home_2), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Iconsax.video_play), label: "Reels"),
            BottomNavigationBarItem(
                icon: Icon(Iconsax.profile_2user), label: "Friends"),
            BottomNavigationBarItem(
                icon: Icon(Iconsax.notification), label: "Notifications"),
            BottomNavigationBarItem(
                icon: Icon(Iconsax.profile_circle), label: "Menu"),
          ],
        );
      },
    );
  }
}
