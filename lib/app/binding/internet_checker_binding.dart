import 'package:facebook_clone_app/app/services/internet_checker_controller.dart';
import 'package:get/get.dart';

class InternetCheckerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InternetCheckerController());
  }
}
