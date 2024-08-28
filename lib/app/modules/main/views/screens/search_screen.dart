import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leadingWidth: 30,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Iconsax.arrow_left_2),
      ),
      title: SizedBox(
        height: 40,
        child: TextField(
          decoration: InputDecoration(
            fillColor: Colors.grey.shade200,
            filled: true,
            isDense: true,
            hintText: 'Search Facebook',
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
