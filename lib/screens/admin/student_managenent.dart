import 'package:flutter/material.dart';

class Student {
  final String name;
  final String email;
  final String batch;
  final String course;
  final double progress;

  Student({
    required this.name,
    required this.email,
    required this.batch,
    required this.course,
    required this.progress,
  });
}

class StudentManagement extends StatefulWidget {
  const StudentManagement({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StudentManagementState createState() => _StudentManagementState();
}

class _StudentManagementState extends State<StudentManagement> {
  String selectedBatch = 'All Batches';
  TextEditingController searchController = TextEditingController();
  
  List<Student> students = [
    Student(
      name: 'Dhruv Jadhav',
      email: 'dhruv12345@gmail.com',
      batch: 'Batch sept 24',
      course: 'UI/UX',
      progress: 0.8,
    ),
    Student(
      name: 'Raj Patil',
      email: 'raj12345@gmail.com',
      batch: 'Batch oct 24',
      course: 'Computer Science',
      progress: 0.4,
    ),
    Student(
      name: 'Dhruv Jadhav',
      email: 'dhruv12345@gmail.com',
      batch: 'Batch sept 24',
      course: 'UI/UX',
      progress: 0.6,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Icon(Icons.menu, size: 24, color: Colors.black87),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Student Management',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Manage all students',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.notifications_outlined, size: 24, color: Colors.black87),
                  SizedBox(width: 16),
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.person, size: 20, color: Colors.grey[600]),
                  ),
                ],
              ),
              
              SizedBox(height: 24),
              
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search students...',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
              
              SizedBox(height: 16),
              
              // Batch Filter Buttons
              Row(
                children: [
                  _buildFilterButton('All Batches'),
                  SizedBox(width: 8),
                  _buildFilterButton('Batch sept 24'),
                  SizedBox(width: 8),
                  _buildFilterButton('Batch nov 24'),
                ],
              ),
              
              SizedBox(height: 24),
              
              // Student Cards
              Expanded(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    return _buildStudentCard(students[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(String text) {
    bool isSelected = selectedBatch == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedBatch = text;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[800] : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.grey[800]! : Colors.grey[300]!,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildStudentCard(Student student) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      student.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '#uid',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  student.email,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  student.batch,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  student.course,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      'Profile: ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: student.progress,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black87),
                        minHeight: 4,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '${(student.progress * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Column(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.visibility_outlined,
                  size: 18,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.delete_outline,
                  size: 18,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}