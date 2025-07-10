import 'package:Pathnova/services/auth_provider.dart' show AuthService;
import 'package:flutter/material.dart';

import 'student_courses_screen.dart';
import 'student_tasks_screen.dart';
import 'student_chat_screen.dart';
import 'student_internship_screen.dart';
import 'student_research_screen.dart';
import 'student_profile_screen.dart';

class StudentDashboardScreen extends StatefulWidget {
  const StudentDashboardScreen({super.key});

  @override
  State<StudentDashboardScreen> createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  Map<String, dynamic>? profileData;
  bool isLoading = true;

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
    ];

    int filled = requiredFields.where((key) {
      final value = profile[key];
      if (value == null) return false;
      if (value is String) return value.trim().isNotEmpty;
      if (value is List) return value.isNotEmpty;
      return true;
    }).length;

    return filled / requiredFields.length;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final name = profileData?['name'] ?? 'Student';
    final profileImageUrl = profileData?['profileImageUrl'];
    final completion = _calculateCompletion(profileData ?? {});

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white.withOpacity(0.8),
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: const [
              Icon(Icons.menu, color: Colors.black),
              SizedBox(width: 10),
              Text(
                'User Dashboard',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
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
                    ? const Icon(
                        Icons.account_circle_outlined,
                        color: Colors.black,
                        size: 32,
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _welcomeCard(name, completion),
            const SizedBox(height: 16),
            _dashboardGrid1(),
            const SizedBox(height: 16),
            _announcementSection(),
            const SizedBox(height: 16),
            _dashboardGrid2(),
          ],
        ),
      ),
    );
  }

  Widget _welcomeCard(String name, double completion) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back, $name!',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 4),
          const Text(
            'Continue building your career profile',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Profile Completion', style: TextStyle(fontSize: 12)),
              const Spacer(),
              Text('${(completion * 100).toInt()}%', style: const TextStyle(fontSize: 12)),
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
          Navigator.push(context, MaterialPageRoute(builder: (_) => StudentCoursesScreen()));
        }),
        _dashboardTile(Icons.track_changes, 'Tasks', () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => StudentTasksScreen()));
        }),
        _dashboardTile(Icons.chat_bubble_outline, 'Chats', () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => StudentChatScreen()));
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
          Navigator.push(context, MaterialPageRoute(builder: (_) => StudentInternshipScreen()));
        }),
        _dashboardTile(Icons.science_outlined, 'Research', () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => StudentResearchScreen()));
        }),
      ],
    );
  }

  Widget _announcementSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('New Announcements', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
                  const Text('New Course Available', style: TextStyle(fontWeight: FontWeight.bold)),
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
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
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
