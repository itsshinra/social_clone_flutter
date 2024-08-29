import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ReelScreen extends StatelessWidget {
  const ReelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: _appBar(),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) {
          return _bodyReel();
        },
      ),
    );
  }

  Stack _bodyReel() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/cpspider.jpg',
          fit: BoxFit.cover,
        ),
        const Positioned(
          left: 10,
          bottom: 45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/placeholder.jpg"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Shinra',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'No problem! Here is the information about the \nMercedes CLR GTR:',
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Positioned(
          right: 10,
          bottom: 20,
          child: Column(
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Iconsax.like_1,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const Text(
                    '74.1k',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Iconsax.message,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const Text(
                    '2.5k',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Iconsax.send_2,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const Text(
                    'Send',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Iconsax.more,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
      title: const Text('Reels'),
      titleTextStyle: const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
      actions: [
        Container(
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Iconsax.search_normal_1,
            ),
          ),
        ),
        Container(
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.camera_alt_outlined,
            ),
          ),
        ),
        Container(
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Iconsax.profile_circle,
            ),
          ),
        ),
        const SizedBox(width: 5),
      ],
    );
  }
}
