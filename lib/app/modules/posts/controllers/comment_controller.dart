import 'package:facebook_clone_app/app/data/models/comment_model.dart';
import 'package:facebook_clone_app/app/data/providers/auth_service.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  final apiService = AuthService();
  var isLoading = false.obs;
  var comments = CommentResModel().obs;

  void updateUI(bool state) {
    isLoading.value = state;
    update();
  }

  Future getComment(String id) async {
    try {
      updateUI(true);
      final commentData = await apiService.getComments(postId: id);
      comments.value = commentData;
      updateUI(false);
    } catch (e) {
      updateUI(false);
      Get.snackbar("Error", e.toString());
    }
  }

  void createComment({required String text, required String id}) async {
    try {
      final status = await apiService.createComment(text: text, postId: id);
      if (status) {
        await getComment(id);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
