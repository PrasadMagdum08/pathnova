import 'package:Pathnova/screens/auth/student_account_creation_screen.dart' show StudentAccountCreationScreen;
import 'package:Pathnova/services/auth_provider.dart' show AuthService;
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isStudent = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginUser() async {
    setState(() => _isLoading = true);
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      final success = await AuthService().login(email, password);
      if (!mounted) return;

      if (success) {
        final role = AuthService().profile?['role'] ?? 'student';
        if (role == 'admin') {
          Navigator.pushReplacementNamed(context, '/admin_dashboard');
        } else {
          Navigator.pushReplacementNamed(context, '/student_dashboard');
        }
      } else {
        _showRegistrationDialog();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showRegistrationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Not Registered'),
        content: Text('You have not registered. Please register first.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => StudentAccountCreationScreen()),
              );
            },
            child: Text('Register'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: Center(
        child: Container(
          width: 360,
          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(20),
                child: const Icon(Icons.school, size: 44, color: Colors.black),
              ),
              const SizedBox(height: 18),
              const Text(
                'PathNova',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Build. Improve. Stand Out.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: Icon(Icons.person,
                          color: isStudent ? Colors.black : Colors.grey),
                      label: Text('Student',
                          style: TextStyle(
                              color: isStudent ? Colors.black : Colors.grey)),
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            isStudent ? Colors.white : Colors.transparent,
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onPressed: () => setState(() => isStudent = true),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      child: Text('Admin',
                          style: TextStyle(
                              color: !isStudent ? Colors.black : Colors.grey)),
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            !isStudent ? Colors.white : Colors.transparent,
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onPressed: () => setState(() => isStudent = false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: isStudent ? 'Student Email' : 'Admin Email',
                  filled: true,
                  fillColor: Colors.grey[50],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade400)),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.grey[50],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade400)),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                child: _isLoading
                    ? CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2)
                    : Text(
                        isStudent ? 'Login as Student' : 'Login as Admin',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 50),
                ),
                onPressed: _isLoading ? null : _loginUser,
              ),
              const SizedBox(height: 8),
              if (isStudent)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",
                        style: TextStyle(fontSize: 13, color: Colors.black)),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const StudentAccountCreationScreen()),
                        );
                      },
                      child: Text('Sign Up',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline)),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
