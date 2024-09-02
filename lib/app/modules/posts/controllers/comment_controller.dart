import 'package:facebook_clone_app/app/data/models/comment_model.dart';
import 'package:facebook_clone_app/app/data/providers/auth_service.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  final apiService = AuthService();
  var isLoading = false;
  CommentResModel comments = CommentResModel();

  void updateUI(bool state) {
    isLoading = state;
    update();
  }

  Future getComment(String id) async {
    try {
      updateUI(true);
      final commentData = await apiService.getComments(postId: id);
      comments = commentData;
      updateUI(false);
    } catch (e) {
      updateUI(false);
      Get.snackbar("Error", e.toString());
    }
  }
}
