import 'dart:io';
import 'package:facebook_clone_app/app/data/models/post_model.dart';
import 'package:facebook_clone_app/app/data/providers/auth_service.dart';
import 'package:facebook_clone_app/app/modules/posts/views/sub_screens/create_post_view.dart';
import 'package:facebook_clone_app/app/services/internet_checker_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PostController extends GetxController {
  var isConnected = false;
  var isLoading = false;
  final apiService = AuthService();
  PostResModel posts = PostResModel();
  final _imagePicker = ImagePicker();
  File? image;

  @override
  void onInit() {
    checkInternet();
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

  Future getPostById(String id) async {
    try {
      updateUI(true);
      final postData = await apiService.getPostById(postId: id);
      posts = postData;
      updateUI(false);
    } catch (e) {
      updateUI(false);
      Get.snackbar("Error", e.toString());
    }
  }

  void deletePost(String id) async {
    try {
      final status = await apiService.deletePost(postId: id);
      if (status) {
        Get.snackbar("Success", "Post deleted successfully");
        getPosts();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void likeDislike(String postId, int postIndex) async {
    try {
      // ignore: unused_local_variable
      final status = await apiService.likeDislike(postId: postId);
      if (posts.posts!.data![postIndex].isLiked!) {
        posts.posts!.data![postIndex].isLiked = false;
        posts.posts!.data![postIndex].likesCount =
            posts.posts!.data![postIndex].likesCount! - 1;
      } else {
        posts.posts!.data![postIndex].isLiked = true;
        posts.posts!.data![postIndex].likesCount =
            posts.posts!.data![postIndex].likesCount! + 1;
      }
      update();
    } catch (e) {
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

  void checkInternet() async {
    final connected = Get.find<InternetCheckerController>().isConnected;
    isConnected = connected;
    update();
  }
}
