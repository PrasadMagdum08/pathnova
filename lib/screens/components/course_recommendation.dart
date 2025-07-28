import 'package:Pathnova/services/auth_provider.dart' show AuthService;
import 'package:flutter/material.dart';

class StudentCoursesScreen extends StatefulWidget {
  const StudentCoursesScreen({super.key});

  @override
  State<StudentCoursesScreen> createState() => _StudentCoursesScreenState();
}

class _StudentCoursesScreenState extends State<StudentCoursesScreen> {
  int selectedTab = 0; // 0 = Enrolled, 1 = Recommend
  List<dynamic> recommendations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRecommendations();
  }

  Future<void> _fetchRecommendations() async {
    setState(() => isLoading = true);
    final result = await AuthService().fetchCourseRecommendations();
    setState(() {
      recommendations = result?['recommendations'] ?? [];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.menu, color: Colors.black),
            SizedBox(width: 10),
            Text('Courses', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none, color: Colors.black), onPressed: () {}),
          IconButton(icon: const Icon(Icons.account_circle_outlined, color: Colors.black), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchAndTabs(),
              const SizedBox(height: 16),
              if (selectedTab == 0) _buildEnrolledCourses() else _buildRecommendedCourses(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchAndTabs() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Search Courses...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() => selectedTab = 0),
                style: OutlinedButton.styleFrom(
                  backgroundColor: selectedTab == 0 ? Colors.black : Colors.white,
                  side: const BorderSide(color: Colors.black26),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text('Enrolled',
                    style: TextStyle(color: selectedTab == 0 ? Colors.white : Colors.black)),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() => selectedTab = 1),
                style: OutlinedButton.styleFrom(
                  backgroundColor: selectedTab == 1 ? Colors.black : Colors.white,
                  side: const BorderSide(color: Colors.black26),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text('Recommend',
                    style: TextStyle(color: selectedTab == 1 ? Colors.white : Colors.black)),
              ),
            ),
            const SizedBox(width: 8),
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  Widget _buildEnrolledCourses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('My Enrolled Courses (2)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _enrolledCourseCard(
          title: 'Data Structures & Algorithms',
          platform: 'udemy',
          status: 'In Progress',
          duration: '2 months',
          progress: 0.3,
          progressLabel: '30%',
          statusColor: Colors.blueGrey,
        ),
        const SizedBox(height: 8),
        _enrolledCourseCard(
          title: 'Cloud Computing with AWS',
          platform: 'coursera',
          status: 'Completed',
          duration: '2 months',
          progress: 1.0,
          progressLabel: '100%',
          statusColor: Colors.green,
        ),
      ],
    );
  }

  Widget _buildRecommendedCourses() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (recommendations.isEmpty) {
      return const Text('No recommended courses found.');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recommended for You (${recommendations.length})',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        for (var course in recommendations)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: _recommendedCourseCard(
              title: course['title'] ?? 'Untitled',
              platform: course['platform'] ?? 'unknown',
              price: course['price'] ?? 'Free',
              rating: double.tryParse(course['rating']?.toString() ?? '0.0') ?? 4.0,
              students: course['students'] ?? 0,
              duration: course['duration'] ?? '4 weeks',
            ),
          ),
      ],
    );
  }

  Widget _enrolledCourseCard({
    required String title,
    required String platform,
    required String status,
    required String duration,
    required double progress,
    required String progressLabel,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black26),
                ),
                child: Text(status, style: TextStyle(fontSize: 11, color: statusColor)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: platform == 'udemy' ? Colors.black : Colors.blue,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(platform, style: const TextStyle(color: Colors.white, fontSize: 10)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text('Duration: $duration', style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 2),
          Row(
            children: [
              Text('Progress: $progressLabel', style: const TextStyle(fontSize: 12)),
              const SizedBox(width: 8),
              Expanded(
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white,
                  color: progress == 1.0 ? Colors.black : Colors.black,
                  minHeight: 6,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _recommendedCourseCard({
    required String title,
    required String platform,
    required String price,
    required double rating,
    required int students,
    required String duration,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black26),
              ),
              child: Text(price, style: const TextStyle(fontSize: 11)),
            ),
          ]),
          const SizedBox(height: 4),
          Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: platform == 'udemy' ? Colors.black : Colors.blue,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(platform, style: const TextStyle(color: Colors.white, fontSize: 10)),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.star, color: Colors.amber, size: 14),
            Text(rating.toString(), style: const TextStyle(fontSize: 12)),
            const SizedBox(width: 8),
            const Icon(Icons.people, size: 14),
            Text(students.toString(), style: const TextStyle(fontSize: 12)),
          ]),
          const SizedBox(height: 4),
          Row(children: [
            const Icon(Icons.access_time, size: 14),
            const SizedBox(width: 4),
            Text(duration, style: const TextStyle(fontSize: 12)),
            const Spacer(),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(80, 28),
                side: const BorderSide(color: Colors.black26),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              ),
              child: const Text('Enroll Now', style: TextStyle(fontSize: 12, color: Colors.black)),
            ),
          ]),
        ],
      ),
    );
  }
}
