import 'package:facebook_clone_app/app/data/models/post_model.dart';
import 'package:facebook_clone_app/app/data/providers/auth_service.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  var isLoading = false;
  final apiService = AuthService();
  PostResModel posts = PostResModel();

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
}
