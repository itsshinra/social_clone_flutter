import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StroySkeleton extends StatelessWidget {
  const StroySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: _storyRow(),
    );
  }

  Widget _storyRow() {
    return SizedBox(
      height: 200,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                width: 115,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 130,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/placeholder.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'Create\nstory',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 3),
          SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 15,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 3, left: 3),
                  child: Container(
                    height: 200,
                    width: 115,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: AssetImage('assets/gtr.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
