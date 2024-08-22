import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: const Center(
        child: Text('HomeScreen'),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      // automaticallyImplyLeading: false,
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
