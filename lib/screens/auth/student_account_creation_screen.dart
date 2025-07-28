import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Pathnova/screens/auth/login_screen.dart';
import 'package:Pathnova/screens/student/student_dashboard_screen.dart';
import 'package:Pathnova/services/auth_provider.dart';

class StudentAccountCreationScreen extends StatefulWidget {
  const StudentAccountCreationScreen({super.key});

  @override
  State<StudentAccountCreationScreen> createState() =>
      _StudentAccountCreationScreenState();
}

class _StudentAccountCreationScreenState
    extends State<StudentAccountCreationScreen> {
  int _currentStep = 0;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _collegeController = TextEditingController();
  final _majorController = TextEditingController();
  final _specializationController = TextEditingController();
  final _skillsController = TextEditingController();
  final _skills2Controller = TextEditingController();
  final _durationController = TextEditingController();
  final _portfolioController = TextEditingController();

  String? _semester;
  String? _batch;
  bool _acceptedTerms = false;

  List<String> semesters = [
    '1st semester',
    '2nd semester',
    '3rd semester',
    '4th semester',
    '5th semester',
    '6th semester',
    '7th semester',
    '8th semester',
  ];

  List<String> batches = ['2023', '2024', '2025', '2026', '2027'];

  void _nextStep() {
    if (_currentStep == 0 && !_formKey.currentState!.validate()) return;
    if (_passwordController.text != _confirmPasswordController.text) {
      _showError("Passwords do not match");
      return;
    }
    if (_currentStep < 3) {
      setState(() => _currentStep++);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _submitRegistration() async {
    setState(() => _isLoading = true);
    final authService = AuthService();

    try {
      final registerResponse = await authService.register(
        name: _fullNameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (!registerResponse) {
        _showError('Registration failed. Please check your details.');
        return;
      }

      final loginResponse = await authService.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (!loginResponse) {
        _showError('Login failed after registration.');
        return;
      }

      final profileData = {
        "name": _fullNameController.text.trim(),
        "email": _emailController.text.trim(),
        "college": _collegeController.text.trim(),
        "semester": _semester ?? '',
        "current_major": _majorController.text.trim(),
        "batch": _batch ?? '',
        "intended_specialized_major": _specializationController.text.trim(),
        "skills": _skillsController.text.trim().split(',').map((e) => e.trim()).toList(),
        "upskilling": _skills2Controller.text.trim().split(',').map((e) => e.trim()).toList(),
        "portfolio_url": _portfolioController.text.trim().split(',').map((e) => e.trim()).toList(),
        "portfolio_building_duration": int.tryParse(_durationController.text.trim()) ?? 0,
      };

      final profileResponse = await http.post(
        Uri.parse('https://pathnova-backend-1.onrender.com/api/profile'),
        headers: {
          'Authorization': 'Bearer ${authService.token ?? ''}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(profileData),
      ).timeout(const Duration(seconds: 10));

      if (profileResponse.statusCode == 201 || profileResponse.statusCode == 200) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const StudentDashboardScreen()),
        );
      } else {
        _showError('Profile creation failed. Please try again.');
      }
    } on TimeoutException {
      _showError('Request timed out. Check your internet connection.');
    } catch (e) {
      _showError('An error occurred: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildStepIndicator() {
    const titles = [
      'Step 1 of 4 - Basic Information',
      'Step 2 of 4 - Academic Details',
      'Step 3 of 4 - Career Goals',
      'Step 4 of 4 - Review & Confirm'
    ];
    return Column(
      children: [
        const Text('Create Student Account', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(titles[_currentStep], style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 8),
        Container(height: 3, width: 180, color: Colors.brown[300]),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name*'),
                validator: (val) => val == null || val.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email*'),
                validator: (val) => val == null || val.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password*'),
                validator: (val) => val == null || val.length < 6 ? "Minimum 6 characters" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Confirm Password*'),
                validator: (val) => val != _passwordController.text ? "Passwords do not match" : null,
              ),
            ],
          ),
        );
      case 1:
        return Column(
          children: [
            TextField(controller: _collegeController, decoration: const InputDecoration(labelText: 'College/University*')),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _semester,
                    decoration: const InputDecoration(labelText: 'Semester*'),
                    items: semesters.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                    onChanged: (v) => setState(() => _semester = v),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _batch,
                    decoration: const InputDecoration(labelText: 'Batch*'),
                    items: batches.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
                    onChanged: (v) => setState(() => _batch = v),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(controller: _majorController, decoration: const InputDecoration(labelText: 'Major/Field of Study*')),
          ],
        );
      case 2:
        return Column(
          children: [
            TextField(controller: _specializationController, decoration: const InputDecoration(labelText: 'Intended Specialization*')),
            const SizedBox(height: 10),
            TextField(controller: _skillsController, decoration: const InputDecoration(labelText: 'Current Skills (comma separated)*')),
            const SizedBox(height: 10),
            TextField(controller: _skills2Controller, decoration: const InputDecoration(labelText: 'Upskilling Goals (comma separated)*')),
            const SizedBox(height: 10),
            TextField(controller: _durationController, decoration: const InputDecoration(labelText: 'Profile Building Duration (months)*')),
            const SizedBox(height: 10),
            TextField(controller: _portfolioController, decoration: const InputDecoration(labelText: 'Portfolio URLs (comma separated)')),
          ],
        );
      case 3:
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black54),
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[100],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${_fullNameController.text}'),
              Text('Email: ${_emailController.text}'),
              Text('College: ${_collegeController.text}'),
              Text('Major: ${_majorController.text}'),
              Text('Semester: ${_semester ?? ''}'),
              Text('Batch: ${_batch ?? ''}'),
              Text('Specialization: ${_specializationController.text}'),
              Text('Duration: ${_durationController.text}'),
            ],
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildButtons() {
    if (_currentStep == 3) {
      return Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: _acceptedTerms,
                onChanged: (v) => setState(() => _acceptedTerms = v ?? false),
              ),
              const Expanded(child: Text('I accept the terms and conditions.', style: TextStyle(fontSize: 12))),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _previousStep,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Previous'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _acceptedTerms ? _submitRegistration : null,
                  icon: const Icon(Icons.check_circle_outline),
                  label: _isLoading
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Create Account'),
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Row(
      children: [
        if (_currentStep > 0)
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _previousStep,
              icon: const Icon(Icons.arrow_back),
              label: const Text('Previous'),
            ),
          ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _nextStep,
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Next Step'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 350,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        if (_currentStep == 0) {
                          Navigator.pop(context);
                        } else {
                          _previousStep();
                        }
                      },
                    ),
                  ),
                  const CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.black12,
                    child: Icon(Icons.school, size: 36),
                  ),
                  const SizedBox(height: 12),
                  _buildStepIndicator(),
                  _buildStepContent(),
                  const SizedBox(height: 20),
                  _buildButtons(),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    ),
                    child: const Text(
                      'Already have an account? Sign In',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
