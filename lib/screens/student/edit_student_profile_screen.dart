import 'package:Pathnova/screens/student/student_dashboard_screen.dart' show AuthService;
import 'package:Pathnova/services/auth_provider.dart' show AuthService;
import 'package:flutter/material.dart';

class EditStudentProfileScreen extends StatefulWidget {
  final Map<String, dynamic> profileData;
  const EditStudentProfileScreen({super.key, required this.profileData});

  @override
  State<EditStudentProfileScreen> createState() => _EditStudentProfileScreenState();
}

class _EditStudentProfileScreenState extends State<EditStudentProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController batchController;
  late TextEditingController majorController;
  late TextEditingController specializationController;
  late TextEditingController skillsController;
  late TextEditingController upskillingController;
  late TextEditingController linkedinController;
  late TextEditingController portfolioController;

  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.profileData['name'] ?? '');
    emailController = TextEditingController(text: widget.profileData['email'] ?? '');
    batchController = TextEditingController(text: widget.profileData['batch'] ?? '');
    majorController = TextEditingController(text: widget.profileData['current_major'] ?? '');
    specializationController = TextEditingController(text: widget.profileData['intended_specialized_major'] ?? '');
    skillsController = TextEditingController(text: (widget.profileData['skills'] ?? []).join(', '));
    upskillingController = TextEditingController(text: (widget.profileData['upskilling'] ?? []).join(', '));
    linkedinController = TextEditingController(text: widget.profileData['linkedin_url'] ?? '');
    portfolioController = TextEditingController(text: (widget.profileData['portfolio_url'] ?? []).join(', '));
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    batchController.dispose();
    majorController.dispose();
    specializationController.dispose();
    skillsController.dispose();
    upskillingController.dispose();
    linkedinController.dispose();
    portfolioController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    setState(() => isSaving = true);

    final updatedData = {
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'batch': batchController.text.trim(),
      'current_major': majorController.text.trim(),
      'intended_specialized_major': specializationController.text.trim(),
      'skills': skillsController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
      'upskilling': upskillingController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
      'portfolio_url': portfolioController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
      'linkedin_url': linkedinController.text.trim(),
      // You can use image picker to allow users to choose profile image
      'profileImageUrl': widget.profileData['profileImageUrl'] ?? 'https://default-profile.img',
    };

    final success = await AuthService().updateStudentProfile(updatedData);
    setState(() => isSaving = false);

    if (success) {
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F3F3),
        elevation: 0,
        title: const Text('Edit Profile', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          isSaving
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))),
                )
              : IconButton(
                  icon: const Icon(Icons.save, color: Colors.black),
                  onPressed: _saveProfile,
                ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: NetworkImage(widget.profileData['profileImageUrl'] ??
                              'https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black12),
                            ),
                            padding: const EdgeInsets.all(2),
                            child: const Icon(Icons.camera_alt, size: 18, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  _inputField('Full Name', nameController),
                  _inputField('Email', emailController),
                  _inputField('Batch', batchController),
                  _inputField('Major', majorController),
                  _inputField('Specialization', specializationController),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Current Skills', style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 6),
                  _inputField('Current Skills (comma separated)', skillsController),
                  const SizedBox(height: 14),
                  const Text('Upskilling Goals', style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 6),
                  _inputField('Upskilling Goals (comma separated)', upskillingController),
                  const SizedBox(height: 14),
                  const Text('Portfolio/LinkedIn', style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  _inputField('LinkedIn URL', linkedinController),
                  _inputField('Portfolio URL(s)', portfolioController),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: _saveProfile,
                child: const Text('Save Changes', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }
}
