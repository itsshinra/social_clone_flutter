// ignore_for_file: avoid_print

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:facebook_clone_app/app/data/models/comment_model.dart';
import 'package:facebook_clone_app/app/data/models/login_model.dart';
import 'package:facebook_clone_app/app/data/models/post_model.dart';
import 'package:facebook_clone_app/app/data/models/user_model.dart';
import 'package:get_storage/get_storage.dart';

class AuthService {
  final dio = Dio(); // use to make HTTP requests
  final box = GetStorage(); // use to store data locally
  final String baseUrl = 'http://10.0.2.2:8000/api';

  //////////////////////  Auth  //////////////////////
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

  //logout user
  Future<bool> logout() async {
    try {
      final response = await dio.post(
        "$baseUrl/logout",
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
      print("statuscode: ${response.statusCode}");
      if (response.statusCode == 200) {
        return true;
      }
      throw Exception("Failed to logout");
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
  /////////////////////// End Auth ///////////////////////

  //////////////////////  Post  //////////////////////
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

  // get postById
  Future<PostResModel> getPostById({required String postId}) async {
    try {
      final response = await dio.get(
        "$baseUrl/posts/$postId",
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

  // Delete post
  Future<bool> deletePost({required String postId}) async {
    try {
      final response = await dio.delete(
        "$baseUrl/posts/$postId",
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
      throw Exception("You cannot delete this post");
    } catch (e) {
      rethrow;
    }
  }

  // Like post
  Future<bool> likeDislike({required String postId}) async {
    try {
      final response = await dio.post(
        "$baseUrl/like-dislike/$postId",
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
      print("statuscode: ${response.statusCode}");
      if (response.statusCode == 200) {
        return true;
      }
      throw Exception("Failed to Like/Dislike post");
    } catch (e) {
      rethrow;
    }
  }
  /////////////////////// End Post ///////////////////////

  //////////////////////  Comment  //////////////////////
  // get comments
  Future<CommentResModel> getComments({required String postId}) async {
    try {
      final response = await dio.get(
        "$baseUrl/comments/$postId",
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
        return CommentResModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      }
      throw Exception("Failed to get comments");
    } catch (e) {
      rethrow;
    }
  }

  // create comments
  Future<bool> createComment(
      {required String text, required String postId}) async {
    try {
      var formData = FormData.fromMap({
        'text': text,
        'post_id': postId,
      });
      final response = await dio.post(
        data: formData,
        "$baseUrl/comments",
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
      throw Exception("Failed to create a comment");
    } catch (e) {
      rethrow;
    }
  }

  // update comments
  Future<bool> updateComment({
    required String text,
    required String commentId,
  }) async {
    try {
      var formData = FormData.fromMap({"text": text});
      final response = await dio.put(
        data: formData,
        "$baseUrl/comments/$commentId",
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
      print("Response: ${response.statusCode}, Data: ${response.data}");

      if (response.statusCode == 200) {
        return true;
      }
      throw Exception("Failed to update a comment");
    } catch (e) {
      rethrow;
    }
  }

  // delete comment
  Future<bool> deleteComment({required String commentId}) async {
    try {
      final response = await dio.delete(
        "$baseUrl/comments/$commentId",
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
      throw Exception("Failed to delete this comment");
    } catch (e) {
      rethrow;
    }
  }
}
