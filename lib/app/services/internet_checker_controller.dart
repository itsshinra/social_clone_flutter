// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetCheckerController extends GetxController {
  var isConnected = false;

  @override
  void onInit() {
    checkInternetConnnection();
    super.onInit();
  }

  Future<void> checkInternetConnnection() async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected) {
      isConnected = true;
      print('Device is connected to the internet');
    } else {
      isConnected = false;
      print("Device is not connected to the internet");
    }
  }
}
