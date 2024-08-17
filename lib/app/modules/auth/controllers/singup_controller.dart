import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SingupController extends GetxController {
  final _imagePicker = ImagePicker();
  File? image;

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
