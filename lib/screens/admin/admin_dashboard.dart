import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}
class _AdminDashboardState extends State<AdminDashboard> {

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
          'Admin Dashboard',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person_outline, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top stats row
              Row(
                children: [
                  _StatCard(
                    icon: Icons.assignment_outlined,
                    count: '2',
                    label: 'Pending Tasks',
                  ),
                  SizedBox(width: 16),
                  _StatCard(
                    icon: Icons.announcement_outlined,
                    count: '12',
                    label: 'Announcements',
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text(
                '+Quick Actions',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'Common administrative tasks',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              SizedBox(height: 16),
              _QuickActionCard(
                icon: Icons.groups_outlined,
                title: 'Manage Students',
                subtitle: 'View, add, or remove students',
                onTap: () {},
                highlight: true,
              ),
              SizedBox(height: 12),
              _QuickActionCard(
                icon: Icons.announcement_outlined,
                title: 'Create Announcement',
                subtitle: 'Post new announcements',
                onTap: () {},
              ),
              SizedBox(height: 12),
              _QuickActionCard(
                icon: Icons.chat_bubble_outline,
                title: 'Chat',
                subtitle: '',
                onTap: () {},
              ),
              SizedBox(height: 12),
              _QuickActionCard(
                icon: Icons.assignment_outlined,
                title: 'Assign Tasks',
                subtitle: 'Create and assign new tasks',
                onTap: () {},
              ),
              SizedBox(height: 12),
              _QuickActionCard(
                icon: Icons.person_add_alt_1_outlined,
                title: 'Add Student',
                subtitle: 'Register new student',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String count;
  final String label;

  const _StatCard({
    required this.icon,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Colors.black87),
            SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(count, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(label, style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool highlight;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: highlight ? Colors.white : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
            color: highlight ? Colors.white : Colors.transparent,
          ),
          child: Row(
            children: [
              Icon(icon, size: 32, color: Colors.black87),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: highlight ? Colors.blue : Colors.black)),
                    if (subtitle.isNotEmpty)
                      Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}