import 'package:flutter/material.dart';

class StudentTasksScreen extends StatelessWidget {
  const StudentTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F3F3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const Icon(Icons.menu, color: Colors.black),
            const SizedBox(width: 10),
            const Text('Tasks', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search tasks, courses or deadlines',
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
                      child: const Text('All Tasks', style: TextStyle(color: Colors.black)),
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
                      child: const Text('Upcoming', style: TextStyle(color: Colors.black)),
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
                      child: const Text('Completed', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _taskSection('My Tasks', [
                _taskCard('Assignment 1: Data Structures', 'Due: 12 Mar 2024', 'In Progress', Colors.orange, 0.5),
                _taskCard('Quiz: Algorithms', 'Due: 15 Mar 2024', 'Upcoming', Colors.blue, 0.0),
                _taskCard('Project: Flutter App', 'Due: 10 Mar 2024', 'Completed', Colors.green, 1.0),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _taskSection(String title, List<Widget> tasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        ...tasks,
      ],
    );
  }

  Widget _taskCard(String task, String due, String status, Color statusColor, double progress) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.assignment_outlined, color: Colors.black),
              const SizedBox(width: 8),
              Expanded(child: Text(task, style: const TextStyle(fontWeight: FontWeight.bold))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: statusColor),
                ),
                child: Text(status, style: TextStyle(fontSize: 11, color: statusColor, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(due, style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white,
            color: statusColor,
            minHeight: 6,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}