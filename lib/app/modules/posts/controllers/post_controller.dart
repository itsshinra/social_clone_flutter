import 'dart:io';
import 'package:facebook_clone_app/app/data/models/post_model.dart';
import 'package:facebook_clone_app/app/data/providers/auth_service.dart';
import 'package:facebook_clone_app/app/modules/posts/views/sub_screens/create_post_view.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PostController extends GetxController {
  var isLoading = false;
  final apiService = AuthService();
  PostResModel posts = PostResModel();
  final _imagePicker = ImagePicker();
  File? image;

  @override
  void onInit() {
    getPosts();
    super.onInit();
  }

  void updateUI(bool state) {
    isLoading = state;
    update();
  }

  Future getPosts() async {
    try {
      updateUI(true);
      final postData = await apiService.getPosts();
      posts = postData;
      updateUI(false);
    } catch (e) {
      updateUI(false);
      Get.snackbar("Error", e.toString());
    }
  }

  void pickImage() async {
    try {
      final xFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (xFile != null) {
        image = File(xFile.path);
        final result = await Get.to(() => CreatePostView(photo: image!));
        if (result) {
          getPosts();
        }
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
