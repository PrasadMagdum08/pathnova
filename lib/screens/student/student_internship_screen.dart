import 'package:flutter/material.dart';

class StudentInternshipScreen extends StatelessWidget {
  const StudentInternshipScreen({super.key});

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
            const Text('Internships', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
                  hintText: 'Search internships, companies or skills',
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
                      child: const Text('Recommended', style: TextStyle(color: Colors.black)),
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
                      child: const Text('Remote', style: TextStyle(color: Colors.black)),
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
                      child: const Text('Internships', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _internshipCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _internshipCard() {
    return Container(
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
              const Icon(Icons.work_outline, color: Colors.black),
              const SizedBox(width: 8),
              const Text('Software Engineering Intern', style: TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 2),
          const Text('Google', style: TextStyle(fontSize: 13)),
          const SizedBox(height: 2),
          Row(
            children: [
              const Icon(Icons.location_on, size: 14),
              const SizedBox(width: 2),
              const Text('Mountain View, CA', style: TextStyle(fontSize: 12)),
              const SizedBox(width: 10),
              const Icon(Icons.calendar_today, size: 14),
              const SizedBox(width: 2),
              const Text('3 months', style: TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black26),
                ),
                child: const Text('Onsite', style: TextStyle(fontSize: 11)),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black26),
                ),
                child: const Text('Internship', style: TextStyle(fontSize: 11)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('About the job', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          const Text('Work on cutting-edge projects with experienced engineers. Contribute to products used by billions.', style: TextStyle(fontSize: 13)),
          const SizedBox(height: 6),
          const Text('Required Skills:', style: TextStyle(fontWeight: FontWeight.bold)),
          const Text('Python'),
          const Text('Java'),
          const Text('Data Structures'),
          const SizedBox(height: 6),
          const Text('Requirements:', style: TextStyle(fontWeight: FontWeight.bold)),
          const Text('- Computer Science student'),
          const Text('- Strong programming skills'),
          const Text('- Problem-solving abilities'),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Posted 2 days ago · Deadline: 15/3/2024', style: TextStyle(fontSize: 12)),
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
                child: const Text('Apply Now', style: TextStyle(fontSize: 12, color: Colors.black)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}