import 'package:facebook_clone_app/app/data/providers/auth_service.dart';
import 'package:facebook_clone_app/app/modules/main/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final authService = AuthService();
  final box = GetStorage();

  void login({required String email, required String password}) async {
    isLoading.value = true;

    try {
      final response =
          await authService.login(email: email, password: password);

      if (response.token != null) {
        box.write("token", response.token);
        Get.snackbar(
          'Success',
          'User logged in successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAll(() => const MainView());
      }
    } catch (e) {
      isLoading.value = false;

      // Show error message in a snackbar
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }
}
