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
      id: 'bottom_navigation_bar',
      builder: (_) {
        return BottomNavigationBar(
          currentIndex: controller.selectedIndex,
          onTap: controller.onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Iconsax.home_2), label: "Home"),
            const BottomNavigationBarItem(
                icon: Icon(Iconsax.video_play), label: "Reels"),
            const BottomNavigationBarItem(
                icon: Icon(Iconsax.profile_2user), label: "Friends"),
            const BottomNavigationBarItem(
                icon: Icon(Iconsax.notification), label: "Notifications"),
            BottomNavigationBarItem(
                icon: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.greenscene.co.id/wp-content/uploads/2022/08/Luffy-4-1200x900.jpg'),
                  ),
                ),
                label: "Menu"),
          ],
        );
      },
    );
  }
}
