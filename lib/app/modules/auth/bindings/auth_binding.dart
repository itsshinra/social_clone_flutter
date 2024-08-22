import 'package:facebook_clone_app/app/modules/auth/controllers/login_controller.dart';
import 'package:facebook_clone_app/app/modules/auth/controllers/singup_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(SingupController());
  }
}
