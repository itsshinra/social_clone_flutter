import 'package:facebook_clone_app/app/binding/internet_checker_binding.dart';
import 'package:facebook_clone_app/app/modules/auth/bindings/auth_binding.dart';
import 'package:facebook_clone_app/app/modules/auth/views/login_view.dart';
import 'package:facebook_clone_app/app/modules/auth/views/signup_view.dart';
import 'package:facebook_clone_app/app/modules/main/binding/main_binding.dart';
import 'package:facebook_clone_app/app/modules/main/middleware/main_middleware.dart';
import 'package:facebook_clone_app/app/modules/main/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/main',
      initialBinding: InternetCheckerBinding(),
      getPages: [
        GetPage(
          name: '/login',
          page: () => LoginView(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/sign_up',
          page: () => SignupView(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/main',
          page: () => const MainView(),
          binding: MainBinding(),
          middlewares: [
            MainMiddleware(),
          ],
        ),
      ],
    );
  }
}
