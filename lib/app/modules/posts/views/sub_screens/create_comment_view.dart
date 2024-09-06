import 'package:facebook_clone_app/app/data/models/comment_model.dart';
import 'package:facebook_clone_app/app/data/models/post_model.dart';
import 'package:facebook_clone_app/app/modules/main/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:get/get.dart';

import '../../controllers/comment_controller.dart';

class CreateCommentView extends StatelessWidget {
  CreateCommentView({super.key, this.postId, this.post});

  final String? postId;
  final Data? post;
  final commentController = Get.put(CommentController());
  final controller = TextEditingController();
  final userController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    commentController.getComment(postId.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post!.caption!),
          ),
          // image
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.65,
            child: Image.network(
              'http://10.0.2.2:8000/posts/${post!.image.toString()}',
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
                child: Row(
                  children: [
                    post!.isLiked!
                        ? const Icon(
                            Iconsax.heart_circle5,
                            color: Colors.pink,
                          )
                        : const Icon(Iconsax.heart_circle),
                    const SizedBox(width: 10),
                    Text(
                      'Love',
                      style: post!.isLiked!
                          ? const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.pink,
                            )
                          : const TextStyle(
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
          post!.likesCount! > 0
              ? Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Icon(
                              Iconsax.heart_circle5,
                              color: Colors.pink,
                            ),
                          ),
                          Text(
                            '${post!.likesCount}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
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
            child: Obx(
              () {
                if (commentController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (commentController.comments.value.comment!.isEmpty) {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.2,
                    child: const Center(child: Text('No comments yet.')),
                  );
                }
                return Column(
                  children: [
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          commentController.comments.value.comment!.length,
                      itemBuilder: (context, index) {
                        final comment =
                            commentController.comments.value.comment![index];
                        final isCurrentUser =
                            comment.userId.toString().trim() ==
                                commentController.currentUserId?.trim();
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: SizedBox(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "http://10.0.2.2:8000/images/${comment.user!.profileImage}"),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // width: 300,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('${comment.user!.name}'),
                                          Text(
                                            '${comment.text}',
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(width: 20),
                                        Text(timeago.format(DateTime.parse(
                                            comment.createdAt!))),
                                        const SizedBox(width: 20),
                                        const Text('Like'),
                                        const SizedBox(width: 20),
                                        const Text('Reply'),
                                        if (isCurrentUser)
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Iconsax.edit_2,
                                                  size: 18,
                                                ),
                                                onPressed: () {
                                                  print(
                                                      'comment id: ${comment.id}');
                                                  print(
                                                      'comment text: ${comment.text}');
                                                  _showEditBottomSheet(
                                                      context,
                                                      comment.id.toString(),
                                                      comment.text.toString());
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Iconsax.trash,
                                                  size: 18,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  _deleteComment(
                                                      context, comment);
                                                },
                                              ),
                                            ],
                                          ),
                                      ],
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      child: Text(
                        'Most relevant is selected, so some comments may have been filtered out.',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomSheet: _bottomTextField(),
    );
  }

  Future<dynamic> _deleteComment(BuildContext context, Comment comment) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete comment'),
        content: const Text('Are you sure you want to delete this comment?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.grey.shade300),
              shape: WidgetStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              commentController.deleteCommnet(
                comment.id.toString(),
                post!.id.toString(),
              );
              Get.back();
            },
            style: ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll(Colors.red),
              shape: WidgetStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
            ),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditBottomSheet(
      BuildContext context, String commentId, String oldText) {
    final editController = TextEditingController(text: oldText);

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8, top: 8),
                  child: CircleAvatar(
                    radius: 13,
                    backgroundImage: NetworkImage(
                        "http://10.0.2.2:8000/images/${userController.user.user!.profileImage!}"),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: editController,
                    autofocus: true,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.grey)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16),
                      hintText: 'Enter your comment',
                    ),
                    maxLines: 5,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(Colors.grey.shade300),
                    shape: WidgetStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    commentController.updateComment(
                      commentId: commentId,
                      text: editController.text.toString(),
                      postId: post!.id.toString(),
                    );
                    Get.back();
                  },
                  style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(Colors.blue),
                    shape: WidgetStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
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
              controller: controller,
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
            onPressed: () {
              commentController.createComment(
                text: controller.text,
                id: postId.toString(),
              );
              controller.clear();
            },
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
          CircleAvatar(
            backgroundImage: NetworkImage(
                "http://10.0.2.2:8000/images/${post!.user!.profileImage}"),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${post!.user!.name}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Row(
                  children: [
                    Text(
                      timeago.format(DateTime.parse(post!.createdAt!)),
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
