import 'dart:io';

import 'package:facebook_clone_app/app/modules/posts/controllers/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdatePostView extends StatefulWidget {
  const UpdatePostView({
    super.key,
    required this.postId,
    required this.oldCaption,
    required this.oldImage,
  });

  final String postId;
  final String oldCaption;
  final String? oldImage;

  @override
  State<UpdatePostView> createState() => _UpdatePostViewState();
}

class _UpdatePostViewState extends State<UpdatePostView> {
  late TextEditingController captionController;
  final postController = PostController();
  File? photo;

  @override
  void initState() {
    super.initState();
    captionController = TextEditingController(text: widget.oldCaption);
  }

  @override
  void dispose() {
    captionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        photo = File(pickedFile.path);
      });
    }
  }

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
        title: const Text('Update Post'),
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
              if (photo == null && widget.oldImage == null) {
                Get.snackbar("Error", "No Image selected");
                return;
              }
              postController.updatePost(
                postId: widget.postId,
                caption: captionController.text,
                photo: photo,
              );
            },
            child: const Text('Update'),
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
                  border: InputBorder.none,
                ),
              ),
            ),
            if (widget.oldImage != null && photo == null)
              Image.network("http://10.0.2.2:8000/posts/${widget.oldImage!}")
            else if (photo != null)
              Image.file(photo!),
            IconButton(
              icon: const Icon(Icons.photo),
              onPressed: () {
                _pickImage();
              },
            ),
          ],
        ),
      ),
    );
  }
}
