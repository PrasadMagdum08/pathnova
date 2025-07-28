import 'package:flutter/material.dart';

class BatchStudentList extends StatelessWidget {
  final String batch;

  BatchStudentList({super.key, required this.batch});

  final List<Map<String, dynamic>> students = [
    {
      'name': 'Dhruv Jadhav', 'email': 'dhruv12345@email.com', 'department': 'UI/UX', 'progress': 80
    },
    {
      'name': 'Raj Patil', 'email': 'raj12345@email.com', 'department': 'Computer Science', 'progress': 40
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(batch)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search students...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  var student = students[index];
                  return Card(
                    child: ListTile(
                      title: Text(student['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(student['email']),
                          Text(batch),
                          Text(student['department']),
                          SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: student['progress'] / 100,
                            color: Colors.black,
                          ),
                          Text('Profile: ${student['progress']}%'),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(icon: Icon(Icons.visibility), onPressed: () {}),
                          IconButton(icon: Icon(Icons.delete), onPressed: () {}),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
