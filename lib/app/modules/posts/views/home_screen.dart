import 'package:facebook_clone_app/app/data/models/post_model.dart';
import 'package:facebook_clone_app/app/modules/posts/controllers/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: GetBuilder<PostController>(
        init: PostController(),
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: () {
              return controller.getPosts();
            },
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://i.pinimg.com/736x/c0/74/9b/c0749b7cc401421662ae901ec8f9f660.jpg"),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "What's on your mind?",
                        style: TextStyle(fontSize: 16),
                      ),
                      Spacer(),
                      Icon(Iconsax.gallery5, color: Colors.green),
                    ],
                  ),
                ),
                const Divider(thickness: 3),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.posts.posts!.data!.length,
                  itemBuilder: (context, index) {
                    final post = controller.posts.posts!.data![index];
                    return _postWidget(post);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Column _postWidget(Data post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              post.user!.profileImage != null
                  ? CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                          "http://10.0.2.2:8000/images/${post.user!.profileImage!}"),
                    )
                  : const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://i.pinimg.com/736x/c0/74/9b/c0749b7cc401421662ae901ec8f9f660.jpg"),
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${post.user!.name}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Row(
                      children: [
                        Text(
                          timeago.format(DateTime.parse(post.createdAt!)),
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
              const Spacer(),
              const Icon(Icons.more_horiz_rounded),
              const SizedBox(width: 15),
              const Icon(Icons.close),
            ],
          ),
        ),
        // caption
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("${post.caption}"),
        ),
        // caption
        Image.network('http://10.0.2.2:8000/posts/${post.image}'),
        const SizedBox(height: 10),
        // Like, Comment, Share Count
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  if (post.likes!.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Iconsax.heart_circle5,
                        color: Colors.pink,
                      ),
                    )
                  else
                    const Icon(Iconsax.heart_circle),
                  const SizedBox(width: 5),
                  Text('${post.likesCount}'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Text('${post.commentsCount} comments'),
                ],
              ),
            ),
          ],
        ),
        // Like, Comment, Share button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
                  Icon(Iconsax.like_1),
                  SizedBox(width: 10),
                  Text(
                    'Like',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
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
        const Divider(thickness: 3),
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
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
