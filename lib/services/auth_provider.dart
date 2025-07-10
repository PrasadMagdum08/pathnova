import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class AuthService {
  // ✅ Singleton setup
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // ✅ API Endpoints
  static const String baseUrl = 'https://pathnova-backend-1.onrender.com/api';
  static const String registerEndpoint = '$baseUrl/auth/register';
  static const String loginEndpoint = '$baseUrl/auth/login';
  static const String profileEndpoint = '$baseUrl/profile';

  String? _token;
  Map<String, dynamic>? _profile;

  String? get token => _token;
  Map<String, dynamic>? get profile => _profile;

  /// ✅ Save token to SharedPreferences
  Future<void> _saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
    _token = token;
  }

  /// ✅ Load token from SharedPreferences
  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('jwt_token');
  }

  /// ✅ Remove token from SharedPreferences
  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    _token = null;
  }

  /// ✅ REGISTER STUDENT OR ADMIN
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
      print("Register failed: ${response.body}");
      return false;
    }
  }

  /// ✅ LOGIN STUDENT OR ADMIN
  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(loginEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      await _saveToken(data['token']);
      _profile = data['user'];
      return true;
    } else {
      print("Login failed: ${response.body}");
      return false;
    }
  }

  /// ✅ FETCH STUDENT PROFILE
  Future<Map<String, dynamic>?> fetchStudentProfile() async {
    if (_token == null) {
      print('Fetch profile failed: No token');
      return null;
    }

    final response = await http.get(
      Uri.parse('$profileEndpoint/fetch_profile'),
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
      },
    );

    print('Profile fetch status: ${response.statusCode}');
    print('Profile fetch body: ${response.body}');
    print('Token used: $_token');
    print('Fetching from: $profileEndpoint');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');


    if (response.statusCode == 200) {
      final profileData = json.decode(response.body);
      _profile = profileData;
      return profileData;
    } else {
      print("Fetch profile failed: ${response.body}");
      return null;
    }
  }

  /// ✅ CREATE OR UPDATE STUDENT PROFILE
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
      print("Update profile failed: ${response.body}");
      return false;
    }
  }

  /// ✅ UPDATE PROFILE IMAGE
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
      print("Update image failed: ${response.body}");
      return false;
    }
  }

  /// ✅ LOGOUT USER
  void logout() {
    _clearToken();
    _profile = null;
  }
}
