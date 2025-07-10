import 'package:Pathnova/services/auth_provider.dart' show AuthService;
import 'package:flutter/material.dart';
import 'edit_student_profile_screen.dart';

class StudentProfileScreen extends StatefulWidget {

    final Map<String, dynamic>? profileData;
  final String? profileImageUrl;

  const StudentProfileScreen({
    super.key,
    this.profileData,
    this.profileImageUrl,
  });

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  Map<String, dynamic>? profileData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    final token = AuthService().token;
    if (token == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    final data = await AuthService().fetchStudentProfile();
    setState(() {
      profileData = data;
      isLoading = false;
    });
    print('Profile Data: $profileData');
  }

  void _navigateToEdit() async {
    if (profileData == null) return;
    final updated = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditStudentProfileScreen(profileData: profileData!),
      ),
    );
    if (updated == true) {
      _fetchProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFFF3F3F3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : profileData == null
              ? const Center(child: Text('Profile not found'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.black12,
                              backgroundImage:
                                  profileData!['profileImageUrl'] != null
                                      ? NetworkImage(profileData!['profileImageUrl'])
                                      : null,
                              child: profileData!['profileImageUrl'] == null
                                  ? const Icon(Icons.person, size: 40)
                                  : null,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(profileData!['name'] ?? '',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  Text(profileData!['email'] ?? ''),
                                  Text('College: ${profileData!['college'] ?? ''}'),
                                  Text('Semester: ${profileData!['semester'] ?? ''}'),
                                  Text('Batch: ${profileData!['batch'] ?? ''}'),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: _navigateToEdit,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildProfileSection(
                        title: 'Academic Information',
                        children: [
                          _infoTile('Major', profileData!['current_major']),
                          _infoTile('Specialization',
                              profileData!['intended_specialized_major']),
                          _infoTile('Portfolio Duration (months)',
                              profileData!['portfolio_building_duration']?.toString()),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildProfileSection(
                        title: 'Skills',
                        children: [
                          _chipList('Skills', profileData!['skills']),
                          const SizedBox(height: 8),
                          _chipList('Upskilling', profileData!['upskilling']),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildProfileSection(
                        title: 'Portfolio Links',
                        children: [
                          if ((profileData!['portfolio_url'] ?? []).isNotEmpty)
                            ...List.generate(
                              (profileData!['portfolio_url'] as List).length,
                              (i) => Text(profileData!['portfolio_url'][i],
                                  style: const TextStyle(fontSize: 14)),
                            )
                          else
                            const Text('No portfolio links'),
                        ],
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _infoTile(String label, String? value) {
    return value != null && value.isNotEmpty
        ? Row(
            children: [
              Text('$label: ',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Expanded(child: Text(value)),
            ],
          )
        : const SizedBox.shrink();
  }

  Widget _chipList(String label, List<dynamic>? values) {
    if (values == null || values.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label:',
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        const SizedBox(height: 4),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: values.map<Widget>((val) {
            return Chip(
              label: Text(val.toString()),
              backgroundColor: Colors.black12,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildProfileSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration:
          BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}
