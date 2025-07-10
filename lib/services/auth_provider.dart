import 'dart:convert';
import 'package:Pathnova/models/course_model.dart' show Course;
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Singleton setup
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // API Endpoints
  static const String baseUrl = 'https://pathnova-backend-1.onrender.com/api';
  static const String registerEndpoint = '$baseUrl/auth/register';
  static const String loginEndpoint = '$baseUrl/auth/login';
  static const String profileEndpoint = '$baseUrl/profile';

  String? _token;
  Map<String, dynamic>? _profile;

  String? get token => _token;
  Map<String, dynamic>? get profile => _profile;

  /// Save token to SharedPreferences
  Future<void> _saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
    _token = token;
  }

  /// Load token from SharedPreferences
  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('jwt_token');
  }

  /// Remove token from SharedPreferences
  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    _token = null;
  }

  /// REGISTER STUDENT OR ADMIN
  Future<bool> register({
    required String name,
    required String email,
    required String password,
    String role = 'student',
  }) async {
    final response = await http.post(
      Uri.parse(registerEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
        'role': role,
      }),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      await _saveToken(data['token']);
      _profile = data['user'];
      return true;
    } else {
      debugPrint("Register failed: ${response.body}");
      return false;
    }
  }

  /// LOGIN STUDENT OR ADMIN
  Future<bool> login(String email, String password) async {
    final url = Uri.parse(loginEndpoint); 
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      debugPrint("Login response status: ${response.statusCode}");
      debugPrint("Login response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _token = data['token']; 
        _profile = data['user']; 
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("Login exception: $e");
      return false;
    }
  }

  /// FETCH STUDENT PROFILE
  Future<Map<String, dynamic>?> fetchStudentProfile() async {
    if (_token == null) {
      debugPrint("No token found. Cannot fetch profile.");
      return null;
    }

    final url = Uri.parse(
      '$profileEndpoint/fetch_profile',
    ); 
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      debugPrint("Profile fetch status: ${response.statusCode}");
      debugPrint("Profile fetch body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _profile = data;
        return data;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Profile fetch exception: $e");
      return null;
    }
  }

  /// CREATE OR UPDATE STUDENT PROFILE
  Future<bool> updateStudentProfile(Map<String, dynamic> data) async {
    if (_token == null) return false;

    final response = await http.post(
      Uri.parse(profileEndpoint),
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      _profile = json.decode(response.body);
      return true;
    } else {
      debugPrint("Update profile failed: ${response.body}");
      return false;
    }
  }

  /// UPDATE PROFILE IMAGE
  Future<bool> updateProfileImage(String imageUrl) async {
    if (_token == null) return false;

    final response = await http.post(
      Uri.parse(profileEndpoint),
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
      },
      body: json.encode({'profileImageUrl': imageUrl}),
    );

    if (response.statusCode == 200) {
      _profile = json.decode(response.body);
      return true;
    } else {
      debugPrint("Update image failed: ${response.body}");
      return false;
    }
  }

  /// FETCH COURSE RECOMMENDATIONS
  Future<Map<String, dynamic>?> fetchCourseRecommendations() async {
    if (_token == null) {
      debugPrint("No token found. Cannot fetch course recommendations.");
      return null;
    }

    final url = Uri.parse(
      'https://pathnova-backend-1.onrender.com/api/courses',
    );
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
        },
      );

      debugPrint("Recommendations status: ${response.statusCode}");
      debugPrint("Recommendations body: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        debugPrint("Failed to fetch recommendations: ${response.body}");
        return null;
      }
    } catch (e) {
      debugPrint("Recommendation fetch exception: $e");
      return null;
    }
  }

  Future<List<Course>> fetchEnrolledCourses() async {
  if (_token == null) return [];

  final response = await http.get(
    Uri.parse('$baseUrl/courses/enrolled'), // your node route
    headers: {'Authorization': 'Bearer $_token'},
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final List<Course> enrolled = (data['enrolled_courses'] as List)
        .map((course) => Course.fromJson(course))
        .toList();
    return enrolled;
  } else {
    debugPrint("Failed to load enrolled courses: ${response.body}");
    return [];
  }
}


  /// ✅ LOGOUT USER
  void logout() {
    _clearToken();
    _profile = null;
  }
}
