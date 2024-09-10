import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CommentListSkeleton extends StatelessWidget {
  const CommentListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: _commentList(),
    );
  }

  Widget _commentList() {
    return Column(
      children: [
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.topCenter,
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/placeholder.jpg"),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // width: 300,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('username'),
                              Text(
                                'comment here for more',
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          child: Text(
            'Most relevant is selected, so some comments may have been filtered out.',
            style: TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}
