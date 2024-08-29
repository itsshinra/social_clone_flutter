import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:get/get.dart';

class CreateCommentView extends StatelessWidget {
  const CreateCommentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Hello guys welcome to my Flutter app"),
          ),
          // image
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.65,
            child: Image.asset(
              'assets/cpspider.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // like, comment, share buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // like button
              ElevatedButton(
                style: const ButtonStyle(
                  elevation: WidgetStatePropertyAll(0),
                  backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                  foregroundColor: WidgetStatePropertyAll(Colors.black),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(Iconsax.heart_circle),
                    SizedBox(width: 10),
                    Text(
                      'Love',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              // comment button
              ElevatedButton(
                style: const ButtonStyle(
                  elevation: WidgetStatePropertyAll(0),
                  backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                  foregroundColor: WidgetStatePropertyAll(Colors.black),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(Iconsax.message),
                    SizedBox(width: 10),
                    Text(
                      'Comment',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              // share button
              ElevatedButton(
                style: const ButtonStyle(
                  elevation: WidgetStatePropertyAll(0),
                  backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                  foregroundColor: WidgetStatePropertyAll(Colors.black),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(Iconsax.send_2),
                    SizedBox(width: 10),
                    Text(
                      'Share',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // like count
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Icon(
                        Iconsax.heart_circle5,
                        color: Colors.pink,
                      ),
                    ),
                    Text(
                      '10',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          // most relevant
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16, right: 5),
                child: Text(
                  'Most relevant',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Icon(Icons.keyboard_arrow_down_rounded, size: 22),
            ],
          ),
          // comment section
          SizedBox(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return _commentItem();
              },
            ),
          ),
        ],
      ),
      bottomSheet: _bottomTextField(),
    );
  }

  Padding _commentItem() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
                  width: 300,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Shinra'),
                      Text(
                        'so cute together, just like me and my girlfriend',
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
                const Row(
                  children: [
                    SizedBox(width: 20),
                    Text('20m'),
                    SizedBox(width: 20),
                    Text('Like'),
                    SizedBox(width: 20),
                    Text('Reply'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  BottomAppBar _bottomTextField() {
    return BottomAppBar(
      height: 65,
      elevation: 0,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.camera_alt_outlined,
              size: 30,
            ),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                hintText: 'Comment on this post',
                hintStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Iconsax.send_2,
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leadingWidth: 38,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
      title: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage("assets/placeholder.jpg"),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Shinra',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Row(
                  children: [
                    Text(
                      timeago.format(DateTime.now()),
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Iconsax.global5,
                      size: 14,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Transform.rotate(
          angle: 90 * 3.14159 / 180,
          child: PopupMenuButton(
            color: Colors.white,
            onSelected: (value) {},
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: "Edit",
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.edit),
                      ),
                      Text(
                        'Edit post',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: "Delete",
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Iconsax.trash),
                      ),
                      Text(
                        'Move to trash',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ];
            },
          ),
        ),
      ],
    );
  }
}
