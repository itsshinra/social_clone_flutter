import 'package:facebook_clone_app/app/modules/main/controllers/main_controller.dart';
import 'package:facebook_clone_app/app/modules/main/views/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MenuScreen extends GetView<MainController> {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => const ProfileScreen());
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 65,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 6,
                      )
                    ],
                  ),
                  child: _profile(),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your shortcuts',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              _forYouShortcut(),
              const Spacer(),
              _logoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text('Menu'),
      titleTextStyle: const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      actions: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade300,
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Iconsax.setting_2,
            ),
          ),
        ),
        // const SizedBox(width: 5),
        Container(
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade300,
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Iconsax.search_normal,
            ),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  SizedBox _forYouShortcut() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 33,
                  backgroundImage: NetworkImage(
                      'https://scontent.fpnh8-2.fna.fbcdn.net/v/t1.30497-1/453178253_471506465671661_2781666950760530985_n.png?stp=dst-png_s200x200&_nc_cat=1&ccb=1-7&_nc_sid=136b72&_nc_eui2=AeHyAf08MNaftrEHmI-gXJ_fWt9TLzuBU1Ba31MvO4FTUBjoLHCqTpEFM9v_g4aQsknGwv-t_CZW7_QqeLQMcG3i&_nc_ohc=qpkbNpQcWu8Q7kNvgFAg42i&_nc_ht=scontent.fpnh8-2.fna&oh=00_AYA4Pxlanb_J3wAepDigVgJ4-VFnMAqKwo_DmPvFkfl17w&oe=66EE517A'),
                ),
                Text(
                  'Noch Noch',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Row _logoutButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: const ButtonStyle(
              elevation: WidgetStatePropertyAll(0),
              backgroundColor: WidgetStatePropertyAll(Colors.black),
              foregroundColor: WidgetStatePropertyAll(Colors.white),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
            ),
            onPressed: () {
              _showLogoutDialog(context);
            },
            child: const Text(
              'Log out',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Row _profile() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
              'https://www.greenscene.co.id/wp-content/uploads/2022/08/Luffy-4-1200x900.jpg'),
        ),
        const SizedBox(width: 15),
        const Text(
          'Shinra',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Container(
          // height: 20,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade300,
          ),
          child: const Icon(
            Iconsax.arrow_down_1,
            size: 24,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog without logging out
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                controller.logout();
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
