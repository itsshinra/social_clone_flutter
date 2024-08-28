import 'dart:io';
import 'package:dio/dio.dart';
import 'package:facebook_clone_app/app/data/models/login_model.dart';
import 'package:facebook_clone_app/app/data/models/post_model.dart';
import 'package:facebook_clone_app/app/data/models/user_model.dart';
import 'package:get_storage/get_storage.dart';

class AuthService {
  final dio = Dio(); // use to make HTTP requests
  final box = GetStorage(); // use to store data locally
  final String baseUrl = 'http://10.0.2.2:8000/api';

  // Login Service
  Future<LoginResModel> login(
      {required String email, required String password}) async {
    try {
      var formData = FormData.fromMap({
        'email': email,
        'password': password,
      });
      final response = await dio.post("$baseUrl/login",
          data: formData,
          options: Options(
            headers: {
              'Accept': 'application/json',
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ));
      if (response.statusCode == 200) {
        return LoginResModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw Exception("Invalid credentials");
      }
      throw Exception("Failed to login");
    } catch (e) {
      rethrow;
    }
  }

  // Sign up service
  Future<bool> register({
    required String name,
    required String email,
    required String password,
    File? image,
  }) async {
    try {
      var formData = FormData.fromMap({
        'email': email,
        'name': name,
        'password': password,
        'image':
            image != null ? await MultipartFile.fromFile(image.path) : null,
      });
      final response = await dio.post(
        "$baseUrl/register",
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400) {
        throw Exception("Email already exists");
      } else {
        throw Exception("Failed to register");
      }
    } catch (e) {
      rethrow;
    }
  }

  // current user
  Future<UserResModel> getCurrentUser() async {
    try {
      final response = await dio.post(
        "$baseUrl/me",
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}',
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        return UserResModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      }
      throw Exception("Failed to get user");
    } catch (e) {
      rethrow;
    }
  }

  // get post
  Future<PostResModel> getPosts() async {
    try {
      final response = await dio.get(
        "$baseUrl/posts",
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}',
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        return PostResModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      }
      throw Exception("Failed to get post");
    } catch (e) {
      rethrow;
    }
  }

  // create post
  Future<bool> createPost(
      {required String caption, required File photo}) async {
    try {
      var formData = FormData.fromMap({
        'caption': caption,
        'image': await MultipartFile.fromFile(photo.path)
      });
      final response = await dio.post(
        data: formData,
        "$baseUrl/posts",
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}',
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      }
      throw Exception("Failed to create a post");
    } catch (e) {
      rethrow;
    }
  }
}
