import 'dart:io';

import 'package:facebook_clone_app/app/modules/posts/controllers/sub_view_controller/create_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePostView extends StatelessWidget {
  CreatePostView({super.key, required this.photo});
  final File photo;
  final controller = Get.put(CreatePostController());
  final captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.close),
        ),
        title: const Text('Create Post'),
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        centerTitle: true,
        actions: [
          TextButton(
            style: const ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(Colors.blue)),
            onPressed: () {
              controller.createPost(
                  caption: captionController.text, photo: photo);
            },
            child: const Text('Post'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: captionController,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: "Say something about this photo...",
                  border: InputBorder.none,
                ),
              ),
            ),
            Image.file(photo),
          ],
        ),
      ),
    );
  }
}
