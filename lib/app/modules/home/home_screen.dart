import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: const Center(
        child: Text('Home Screen'),
      ),
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  BottomNavigationBar _bottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black,
      items: [
        const BottomNavigationBarItem(
            icon: Icon(Iconsax.home_25), label: "Home"),
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
  }

  AppBar _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('facebook'),
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
              Iconsax.add,
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
        // const SizedBox(width: 5),
        Badge(
          backgroundColor: Colors.red,
          textColor: Colors.white,
          label: const Text('2'),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade300,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Iconsax.message,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
