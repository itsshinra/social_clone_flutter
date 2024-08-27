import 'package:facebook_clone_app/app/modules/main/controllers/main_controller.dart';
import 'package:facebook_clone_app/app/modules/main/controllers/profile_controller.dart';
import 'package:facebook_clone_app/app/modules/main/views/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

// ignore: must_be_immutable
class MenuScreen extends GetView<MainController> {
  MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: ListView(
        padding: const EdgeInsets.all(8),
        physics: const BouncingScrollPhysics(),
        children: [
          _profile(),
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
          const SizedBox(height: 16),
          _memoriesGrid(),
          const SizedBox(height: 10),
          _darkMode(),
          _helpSupport(),
          _helpSupport(),
          _helpSupport(),
          const Spacer(),
          _logoutButton(context),
        ],
      ),
    );
  }

  Card _darkMode() {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: const Icon(Iconsax.moon5),
        title: const Text(
          'Dark Mode',
          style: TextStyle(fontSize: 16),
        ),
        trailing: Switch(
          value: false,
          onChanged: (value) {},
        ),
      ),
    );
  }

  Column _helpSupport() {
    return const Column(
      children: [
        Divider(),
        ListTile(
          style: ListTileStyle.drawer,
          dense: true,
          leading: Icon(
            Iconsax.info_circle5,
            size: 32,
          ),
          title: Text(
            'Help & support',
            style: TextStyle(fontSize: 16),
          ),
          trailing: Icon(Icons.keyboard_arrow_down_rounded),
        ),
      ],
    );
  }

  GestureDetector _profile() {
    return GestureDetector(
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
        child: GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (userController) {
            if (userController.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      'http://10.0.2.2:8000/images/${userController.user.user!.profileImage!}'),
                ),
                const SizedBox(width: 15),
                Text(
                  '${userController.user.user!.name}',
                  style: const TextStyle(
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
                    Icons.keyboard_arrow_down_rounded,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  SizedBox _memoriesGrid() {
    return SizedBox(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.2,
        ),
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: item.length,
        itemBuilder: (context, index) {
          final items = item[index];
          return Container(
            height: 80,
            width: MediaQuery.sizeOf(context).width * 0.5,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('${items.image}', width: 30),
                Text(
                  '${items.name}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        },
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
              Iconsax.search_normal_1,
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

  var item = [
    ItemGrid(name: 'Memories', image: 'assets/memories.png'),
    ItemGrid(name: 'Video', image: 'assets/video.png'),
    ItemGrid(name: 'Saved', image: 'assets/saved.png'),
    ItemGrid(name: 'Groups', image: 'assets/groups.png'),
    ItemGrid(name: 'Friends', image: 'assets/friend.png'),
    ItemGrid(name: 'Feeds', image: 'assets/feed.png'),
    ItemGrid(name: 'Reels', image: 'assets/reel.png'),
    ItemGrid(name: 'Pages', image: 'assets/page.png'),
  ];
}

class ItemGrid {
  String? name;
  String? image;
  ItemGrid({required this.name, required this.image});
}
