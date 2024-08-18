import 'dart:io';

import 'package:facebook_clone_app/app/data/services/auth_service.dart';
import 'package:facebook_clone_app/app/modules/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SingupController extends GetxController {
  final _imagePicker = ImagePicker();
  File? image;

  final AuthService authService;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  SingupController({required this.authService});

  Future<void> register(String name, String email, String password) async {
    isLoading.value = true;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      errorMessage.value = "All fields are required";
      Get.snackbar('Error', errorMessage.value,
          snackPosition: SnackPosition.BOTTOM);
      isLoading.value = false;
      return;
    }

    try {
      // ignore: unused_local_variable
      final response = await authService.register(
        name: name,
        email: email,
        password: password,
        image: image,
      );

      Get.to(() => const HomeScreen());
      Get.snackbar('Success', 'User registered successfully');
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', errorMessage.value,
          snackPosition: SnackPosition.BOTTOM);
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
