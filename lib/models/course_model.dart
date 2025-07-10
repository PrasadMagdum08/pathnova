// models/course_model.dart
class Course {
  final String title;
  final String platform;
  final String status;
  final String duration;
  final double progress;

  Course({
    required this.title,
    required this.platform,
    required this.status,
    required this.duration,
    required this.progress,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      title: json['title'] ?? '',
      platform: json['platform'] ?? 'unknown',
      status: json['status'] ?? 'Not Started',
      duration: json['duration'] ?? '4 weeks',
      progress: (json['progress'] ?? 0).toDouble(),
    );
  }
}
