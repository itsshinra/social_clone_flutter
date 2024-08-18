import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  // Login Service
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  // Sign up service
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    File? image,
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/register'));

    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['password'] = password;

    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
        filename: image.path.split('/').last,
      ));
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      return json.decode(responseData);
    } else if (response.statusCode == 422) {
      var responseData = await response.stream.bytesToString();
      throw Exception(json.decode(responseData)['error'].toString());
    } else {
      throw Exception('Registration failed. Please try again.');
    }
  }
}
