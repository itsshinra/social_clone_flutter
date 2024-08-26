import 'package:facebook_clone_app/app/data/models/user_model.dart';
import 'package:facebook_clone_app/app/data/providers/auth_service.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final apiService = AuthService();
  UserResModel user = UserResModel();
  var isLoading = false;

  void updateUI(bool state) {
    isLoading = state;
    update();
  }

  void me() async {
    try {
      updateUI(true);
      final user = await apiService.getCurrentUser();
      if (user.user != null) {
        this.user = user;
        updateUI(false); // refresh the UI
      }
    } catch (e) {
      updateUI(false);
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  void onInit() {
    me();
    super.onInit();
  }
}
