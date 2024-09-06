import 'package:facebook_clone_app/app/data/models/comment_model.dart';
import 'package:facebook_clone_app/app/data/providers/auth_service.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  final apiService = AuthService();
  var isLoading = false.obs;
  var comments = CommentResModel().obs;

  String? currentUserId;

  @override
  void onInit() {
    super.onInit();
    _fetchCurrentUser();
  }

  void updateUI(bool state) {
    isLoading.value = state;
    update();
  }

  Future<void> _fetchCurrentUser() async {
    try {
      final user = await apiService.getCurrentUser();
      currentUserId = user.user!.id.toString();
      update();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
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

  Future<void> updateComment({
    required String commentId,
    required String text,
    required String postId,
  }) async {
    try {
      updateUI(true);
      final status =
          await apiService.updateComment(text: text, commentId: commentId);
      if (status) {
        await getComment(postId);
      }
      updateUI(false);
    } catch (e) {
      updateUI(false);
      Get.snackbar("Error", e.toString());
    }
  }

  void deleteCommnet(String commentId, String postId) async {
    try {
      final status = await apiService.deleteComment(commentId: commentId);
      if (status) {
        Get.snackbar("Success", "Comment deleted successfully");
        getComment(postId);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
