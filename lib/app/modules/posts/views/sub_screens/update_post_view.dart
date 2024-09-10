import 'dart:io';

import 'package:facebook_clone_app/app/modules/posts/controllers/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content:
                    const Text("If you discard now, you'll lose this post."),
                actions: [
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
                      'Keep editing',
                      style:
                          TextStyle(color: Color.fromARGB(255, 44, 134, 207)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.offAllNamed('/main');
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
                      'Discard Editing',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
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
          ],
        ),
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Container _bottomBar() {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(0, 2))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(
              Iconsax.gallery5,
              color: Colors.green,
            ),
            onPressed: () {
              _pickImage();
            },
          ),
          IconButton(
            icon: const Icon(
              Iconsax.tag_user5,
              color: Color.fromARGB(255, 52, 127, 189),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Iconsax.emoji_happy,
              color: Color.fromARGB(255, 211, 136, 39),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Iconsax.location5,
              color: Color.fromARGB(255, 148, 56, 3),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.camera_alt,
              color: Color.fromARGB(255, 52, 127, 189),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Iconsax.attach_circle),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
