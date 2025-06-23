import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class NetworkService {
  static const String baseUrl = 'https://pathnova-backend.onrender.com/api/users'; // Use 10.0.2.2 for Android emulator

  static Future<http.Response> register(String name, String email, String password, String role) {
    return http.post(
      Uri.parse('$baseUrl/register/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'role': role,
      }),
    );
  }

  static Future<http.Response> login(String email, String password, String role) {
    return http.post(
      Uri.parse('$baseUrl/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'role': role,
      }),
    );
  }

    static Future<http.Response> firebaseRegister(String name, String email, String role) {
    return http.post(
      Uri.parse('$baseUrl/firebase-register/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'role': role,
        'auth_provider': 'firebase',
      }),
    );
  }

    static Future<String?> getUserRole(String email) async {
    final response = await http.get(
      Uri.parse('$baseUrl/role?email=$email'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['role'];
    }
    return null;
  }
}