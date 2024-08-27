import 'package:facebook_clone_app/app/data/models/post_model.dart';
import 'package:facebook_clone_app/app/modules/main/controllers/profile_controller.dart';
import 'package:facebook_clone_app/app/modules/posts/controllers/post_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
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
                _whatOnYourMind(),
                const Divider(thickness: 4),
                _storyRow(),
                const Divider(thickness: 4),
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

  Widget _storyRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: SizedBox(
        height: 200,
        child: GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (userController) {
            if (userController.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 200,
                      width: 115,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 130,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'http://10.0.2.2:8000/images/${userController.user.user!.profileImage}'),
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
                    Positioned(
                      left: 30,
                      bottom: 50,
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade100,
                            width: 3,
                          ),
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Iconsax.add,
                            color: Colors.white,
                          ),
                        ),
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
                        child: Stack(
                          children: [
                            Container(
                              height: 200,
                              width: 115,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15),
                                image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://w0.peakpx.com/wallpaper/29/935/HD-wallpaper-nissan-gtr-r34-black-car-gtr-r34-thumbnail.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const Positioned(
                              bottom: 5,
                              left: 8,
                              child: Text(
                                'shin ra',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 2,
                              top: 5,
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: const CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://i.pinimg.com/736x/c0/74/9b/c0749b7cc401421662ae901ec8f9f660.jpg"),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Padding _whatOnYourMind() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (userController) {
          if (userController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "http://10.0.2.2:8000/images/${userController.user.user!.profileImage!}"),
              ),
              const SizedBox(width: 10),
              const Text(
                "What's on your mind?",
                style: TextStyle(fontSize: 16),
              ),
              const Spacer(),
              const Icon(Iconsax.gallery5, color: Colors.green),
            ],
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
        // image
        Image.network(
          'http://10.0.2.2:8000/posts/${post.image}',
        ),
        const SizedBox(height: 10),
        // Like, Comment, Share Count
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // like
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: post.likes!.isNotEmpty
                  ? Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Iconsax.heart_circle5,
                            color: Colors.pink,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text('${post.likesCount}'),
                      ],
                    )
                  : null,
            ),
            // comment
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  if (post.comments!.isNotEmpty)
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
        const Divider(thickness: 4),
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
              Iconsax.search_normal_1,
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
                Iconsax.message5,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
