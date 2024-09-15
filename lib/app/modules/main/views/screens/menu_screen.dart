import 'package:facebook_clone_app/app/modules/main/controllers/main_controller.dart';
import 'package:facebook_clone_app/app/modules/main/controllers/profile_controller.dart';
import 'package:facebook_clone_app/app/modules/main/views/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ignore: must_be_immutable
class MenuScreen extends GetView<MainController> {
  MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          _yourShortcut(),
          const SizedBox(height: 16),
          _memoriesGrid(),
          const SizedBox(height: 10),
          _darkMode(),
          _helpSupport(),
          _helpSupport(),
          _helpSupport(),
          _logoutButton(context),
        ],
      ),
    );
  }

  Widget _darkMode() {
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

  Card _helpSupport() {
    return const Card(
      color: Colors.white,
      child: ListTile(
        leading: Icon(Iconsax.info_circle),
        title: Text(
          'Help & support',
          style: TextStyle(fontSize: 16),
        ),
        trailing: Icon(Icons.keyboard_arrow_down_rounded),
      ),
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
              return _loadingSkeleton();
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

  Widget _loadingSkeleton() {
    return const Center(
      child: Skeletonizer(
        enabled: true,
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/placeholder.jpg'),
            ),
            SizedBox(width: 15),
            Text(
              'username',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _memoriesGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.2,
      ),
      physics: const NeverScrollableScrollPhysics(), // Disable scrolling
      shrinkWrap: true, // Adjusts GridView's height to fit its children
      itemCount: item.length,
      itemBuilder: (context, index) {
        final items = item[index];
        return Container(
          height: 80,
          width: MediaQuery.of(context).size.width * 0.5,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 2,
              )
            ],
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
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text('Menu'),
      backgroundColor: Colors.white,
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

  Widget _yourShortcut() {
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
                  backgroundImage: AssetImage('assets/placeholder.jpg'),
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
            style: ButtonStyle(
              elevation: WidgetStateProperty.all(0),
              backgroundColor: WidgetStateProperty.all(Colors.black),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              shape: WidgetStateProperty.all(
                const RoundedRectangleBorder(
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
