import 'package:facebook_clone_app/app/data/models/user_model.dart';
import 'package:facebook_clone_app/app/data/providers/auth_service.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final apiService = AuthService();
  UserResModel user = UserResModel();

  void me() async {
    final user = await apiService.getCurrentUser();

    if (user.user != null) {
      this.user = user;
      update(); // refresh the UI
    }
  }

  @override
  void onInit() {
    me();
    super.onInit();
  }
}
