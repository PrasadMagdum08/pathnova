import 'package:flutter/material.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9),
      appBar: AppBar(
        backgroundColor: Color(0xFFD9D9D9),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        title: Text(
          'My Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              // Profile Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 38,
                          backgroundColor: Colors.grey[200],
                          child: Icon(Icons.account_circle, size: 70, color: Colors.black45),
                        ),
                        Positioned(
                          bottom: 4,
                          right: 4,
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.camera_alt, size: 16, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dhruv Jadhav',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '#uid',
                            style: TextStyle(fontSize: 13, color: Colors.black54),
                          ),
                          Text(
                            'dhruv12345@email.com',
                            style: TextStyle(fontSize: 13, color: Colors.black54),
                          ),
                          Text(
                            'Batch sept\'24',
                            style: TextStyle(fontSize: 13, color: Colors.black54),
                          ),
                          Text(
                            'UI/UX',
                            style: TextStyle(fontSize: 13, color: Colors.black54),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                'Profile Completion',
                                style: TextStyle(fontSize: 13, color: Colors.black87),
                              ),
                              Spacer(),
                              Text(
                                '80%',
                                style: TextStyle(fontSize: 13, color: Colors.black87),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: 0.8,
                              minHeight: 7,
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.black87),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Skills & Development Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.emoji_objects_outlined, size: 22, color: Colors.black87),
                        SizedBox(width: 6),
                        Text(
                          'Skills & Development',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Current Skills',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                    SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        _SkillChip('User Research'),
                        _SkillChip('Visual Design'),
                        _SkillChip('Wireframing & Prototyping'),
                        _SkillChip('Figma'),
                      ],
                    ),
                    SizedBox(height: 14),
                    Text(
                      'Upskilling Goals',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                    SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        _SkillChip('Framer'),
                        _SkillChip('UX Writing'),
                      ],
                    ),
                    SizedBox(height: 14),
                    Text(
                      'Portfolio/LinkedIn',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'https://linkedin.com/in/dhruvjadav',
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              // Placeholder for additional content
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  const _SkillChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 13, color: Colors.black87),
      ),
    );
  }
}