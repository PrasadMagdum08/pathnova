import 'package:flutter/material.dart';
import 'package:Pathnova/services/auth_provider.dart' show AuthService;

import 'student_enrolled_courses_screen.dart';
import 'student_tasks_screen.dart';
import 'student_chat_screen.dart';
import 'student_internship_screen.dart';
import 'student_research_screen.dart';
import 'student_profile_screen.dart';
import 'edit_student_profile_screen.dart';

class StudentDashboardScreen extends StatefulWidget {
  const StudentDashboardScreen({super.key});

  @override
  State<StudentDashboardScreen> createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  Map<String, dynamic>? profileData;
  bool isLoading = true;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final token = AuthService().token;
    if (token == null) {
      setState(() => isLoading = false);
      return;
    }

    final data = await AuthService().fetchStudentProfile();
    setState(() {
      profileData = data;
      isLoading = false;
    });
  }

  double _calculateCompletion(Map<String, dynamic> profile) {
    final requiredFields = [
      'name',
      'email',
      'college',
      'semester',
      'current_major',
      'batch',
      'intended_specialized_major',
      'skills',
      'upskilling',
      'portfolio_url',
      'portfolio_building_duration'
    ];

    int filled = 0;
    for (var field in requiredFields) {
      final value = profile[field];
      if (value is String && value.trim().isNotEmpty) {
        filled++;
      } else if (value is List && value.isNotEmpty) {
        filled++;
      }
    }

    return requiredFields.isEmpty ? 0 : filled / requiredFields.length;
  }

  List<String> _getMissingFields(Map<String, dynamic> profile) {
    final requiredFields = {
      'name': 'Name',
      'email': 'Email',
      'college': 'College',
      'semester': 'Semester',
      'current_major': 'Major',
      'batch': 'Batch',
      'intended_specialized_major': 'Specialization',
      'skills': 'Skills',
      'upskilling': 'Upskilling',
      'portfolio_url': 'Portfolio URL',
      'portfolio_building_duration': 'Portfolio Duration',
    };

    List<String> missing = [];

    requiredFields.forEach((key, label) {
      final value = profile[key];
      if (value is String && value.trim().isEmpty) {
        missing.add(label);
      } else if (value is List && value.isEmpty) {
        missing.add(label);
      } else if (value == null) {
        missing.add(label);
      }
    });

    return missing;
  }

  Widget _missingFieldsAlert(List<String> missingFields) {
    if (missingFields.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('⚠️ Profile Incomplete',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 6),
          const Text('Complete the following fields:',
              style: TextStyle(fontSize: 13, color: Colors.black87)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: missingFields
                .map((field) => Chip(
                      label: Text(field),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.orange),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditStudentProfileScreen(
                      profileData: profileData!,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.edit, color: Colors.deepOrange),
              label: const Text('Complete Now',
                  style: TextStyle(color: Colors.deepOrange)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _homeScreenBody() {
    final name = (profileData?['name'] ?? '').toString().trim();
    final displayName = name.isNotEmpty ? name : 'Student';
    final completion = _calculateCompletion(profileData ?? {});
    final missingFields = _getMissingFields(profileData ?? {});
    final profileImageUrl = profileData?['profileImageUrl'];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _welcomeCard(displayName, completion),
          _missingFieldsAlert(missingFields),
          const SizedBox(height: 16),
          _dashboardGrid1(),
          const SizedBox(height: 16),
          _announcementSection(),
          const SizedBox(height: 16),
          _dashboardGrid2(),
        ],
      ),
    );
  }

  Widget _bottomTabScreen() {
    switch (_selectedIndex) {
      case 0:
        return _homeScreenBody();
      case 1:
        return const StudentEnrolledCoursesScreen();
      case 2:
        return const Center(child: Text('🧠 Pathnova AI Coming Soon'));
      case 3:
        return const Center(child: Text('⚙️ Settings Page Coming Soon'));
      default:
        return _homeScreenBody();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final profileImageUrl = profileData?['profileImageUrl'];

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0,
        title: const Text('User Dashboard',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => StudentProfileScreen(
                    profileData: profileData,
                    profileImageUrl: profileImageUrl,
                  ),
                ),
              );
            },
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey[200],
              backgroundImage: profileImageUrl != null
                  ? NetworkImage(profileImageUrl)
                  : null,
              child: profileImageUrl == null
                  ? const Icon(Icons.account_circle_outlined,
                      color: Colors.black, size: 32)
                  : null,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _bottomTabScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.smart_toy), label: 'Pathnova AI'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _welcomeCard(String name, double completion) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome back, $name!',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(height: 4),
          const Text('Continue building your career profile',
              style: TextStyle(fontSize: 14, color: Colors.black87)),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Profile Completion', style: TextStyle(fontSize: 12)),
              const Spacer(),
              Text('${(completion * 100).toInt()}%',
                  style: const TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: completion,
            backgroundColor: Colors.grey[300],
            color: Colors.black,
            minHeight: 6,
          ),
        ],
      ),
    );
  }

  Widget _dashboardGrid1() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.2,
      children: [
        _dashboardTile(Icons.menu_book_outlined, 'Courses', () {
          setState(() => _selectedIndex = 1);
        }),
        _dashboardTile(Icons.track_changes, 'Tasks', () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => StudentTasksScreen()));
        }),
        _dashboardTile(Icons.chat_bubble_outline, 'Chats', () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => StudentChatScreen()));
        }),
        _dashboardTile(Icons.folder_open, 'Projects', () {
          // TODO: Add project screen
        }),
      ],
    );
  }

  Widget _dashboardGrid2() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.2,
      children: [
        _dashboardTile(Icons.work_outline, 'Internship', () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => StudentInternshipScreen()));
        }),
        _dashboardTile(Icons.science_outlined, 'Research', () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => StudentResearchScreen()));
        }),
      ],
    );
  }

  Widget _announcementSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('New Announcements',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('New Course Available',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  _announcementTag('Important'),
                  const SizedBox(width: 4),
                  _announcementTag('Academic'),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Advanced React Development course is now available for enrollment',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Target: All students', style: TextStyle(fontSize: 11)),
                  Text('By: Admin', style: TextStyle(fontSize: 11)),
                  Text('20/8/2025', style: TextStyle(fontSize: 11)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dashboardTile(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black12),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.black, size: 26),
              const SizedBox(width: 8),
              Text(label,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _announcementTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black26),
      ),
      child: Text(label, style: const TextStyle(fontSize: 10)),
    );
  }
}
