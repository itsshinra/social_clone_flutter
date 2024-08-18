import 'package:facebook_clone_app/app/data/services/auth_service.dart';
import 'package:facebook_clone_app/app/modules/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var token = ''.obs;
  var errorMessage = ''.obs;

  final AuthService authService;

  LoginController({required this.authService});

  Future<void> login(String email, String password) async {
    isLoading.value = true;

    try {
      final data = await authService.login(email, password);

      if (data['status'] == 'error' &&
          data['message'] == 'Incorrect password') {
        // Handle incorrect password
        errorMessage.value = 'Incorrect password. Please try again.';
        Get.snackbar('Error', errorMessage.value,
            snackPosition: SnackPosition.BOTTOM);
      } else {
        // Handle successful login
        token.value = data['token'];
        Get.to(() => const HomeScreen());
        Get.snackbar('Success', 'User logged in successfully',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
      }
    } catch (e) {
      isLoading.value = false;

      // Check for specific error messages or status codes
      if (e.toString().contains('Incorrect password')) {
        errorMessage.value = 'Incorrect password. Please try again.';
      } else if (e.toString().contains('Email not found')) {
        errorMessage.value = 'Email not found. Please check your email.';
      } else {
        errorMessage.value = 'An unexpected error occurred. Please try again.';
      }

      // Show error message in a snackbar
      Get.snackbar('Error', errorMessage.value,
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
