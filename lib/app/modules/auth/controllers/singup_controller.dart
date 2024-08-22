import 'dart:io';
import 'package:facebook_clone_app/app/data/providers/auth_service.dart';
import 'package:facebook_clone_app/app/modules/main/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SingupController extends GetxController {
  final _imagePicker = ImagePicker();
  File? image;

  final authService = AuthService();
  var isLoading = false.obs;

  Future<bool> register(
      {required String name,
      required String email,
      required String password}) async {
    isLoading.value = true;

    try {
      // ignore: unused_local_variable
      final response = await authService.register(
        name: name,
        email: email,
        password: password,
        image: image,
      );
      if (response) {
        Get.offAll(() => const MainView());
        Get.snackbar(
          'Success',
          'User registered successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return true;
      }
      return false;
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void pickImage() async {
    try {
      final xFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (xFile != null) {
        image = File(xFile.path);
        update();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
