import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WhatOnYourMindSkeleton extends StatelessWidget {
  const WhatOnYourMindSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: _whatOnYourMind(),
    );
  }

  Widget _whatOnYourMind() {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage("assets/placeholder.jpg"),
        ),
        const SizedBox(width: 10),
        const Text(
          "What's on your mind?",
          style: TextStyle(fontSize: 16),
        ),
        const Spacer(),
        IconButton(onPressed: () {}, icon: const Icon(Icons.photo))
      ],
    );
  }
}
