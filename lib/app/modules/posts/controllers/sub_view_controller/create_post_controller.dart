import 'dart:io';

import 'package:facebook_clone_app/app/data/providers/auth_service.dart';
import 'package:get/get.dart';

class CreatePostController extends GetxController {
  final apiService = AuthService();

  void createPost({required String caption, required File photo}) async {
    try {
      final status =
          await apiService.createPost(caption: caption, photo: photo);
      if (status) {
        Get.back(result: true);
        Get.snackbar("Success", "Post created successfully");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
