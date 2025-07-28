import 'package:Pathnova/services/auth_provider.dart' show AuthService;
import 'package:flutter/material.dart';
import '../../models/course_model.dart';

class StudentEnrolledCoursesScreen extends StatefulWidget {
  const StudentEnrolledCoursesScreen({super.key});

  @override
  State<StudentEnrolledCoursesScreen> createState() => _StudentEnrolledCoursesScreenState();
}

class _StudentEnrolledCoursesScreenState extends State<StudentEnrolledCoursesScreen> {
  List<Course> enrolledCourses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadEnrolledCourses();
  }

  Future<void> loadEnrolledCourses() async {
    final courses = await AuthService().fetchEnrolledCourses();
    setState(() {
      enrolledCourses = courses;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.black26),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('All Courses', style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.black26),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Recommend', style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('My Enrolled Courses (${enrolledCourses.length})',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  ...enrolledCourses.map((course) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: _enrolledCourseCard(
                          title: course.title,
                          platform: course.platform,
                          status: course.status,
                          duration: course.duration,
                          progress: course.progress,
                          progressLabel: '${(course.progress * 100).toInt()}%',
                          statusColor: course.progress == 1.0 ? Colors.green : Colors.blueGrey,
                        ),
                      )),
                  const SizedBox(height: 18),
                  const Text('Recommended for You', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  _recommendedCourseCard(
                    title: 'Machine Learning Fundamentals',
                    platform: 'udemy',
                    price: 'Free',
                    rating: 4.6,
                    students: 22100,
                    duration: '7 weeks',
                  ),
                  const SizedBox(height: 8),
                  _recommendedCourseCard(
                    title: 'Advanced React Development',
                    platform: 'udemy',
                    price: '\u20B9852',
                    rating: 4.8,
                    students: 12500,
                    duration: '8 weeks',
                  ),
                  const SizedBox(height: 8),
                  _recommendedCourseCard(
                    title: 'Advanced React Development',
                    platform: 'coursera',
                    price: '\u20B9752',
                    rating: 4.9,
                    students: 13500,
                    duration: '8 weeks',
                  ),
                ],
              ),
            ),
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
                child: Text(price, style: const TextStyle(fontSize: 11)),
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
              const SizedBox(width: 8),
              const Icon(Icons.star, color: Colors.amber, size: 14),
              Text(rating.toString(), style: const TextStyle(fontSize: 12)),
              const SizedBox(width: 8),
              const Icon(Icons.people, size: 14),
              Text(students.toString(), style: const TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
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
            ],
          ),
        ],
      ),
    );
  }
}
