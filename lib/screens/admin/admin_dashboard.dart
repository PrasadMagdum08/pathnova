import 'package:flutter/material.dart';

void main() => runApp(AdminApp());

class AdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AdminDashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  void _navigate(BuildContext context, String label) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: Text(label)),
          body: Center(child: Text("This is $label screen")),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, IconData icon, String count) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            children: [
              Icon(icon, size: 28),
              const SizedBox(height: 6),
              Text(count, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    String screenName,
  ) {
    return GestureDetector(
      onTap: () => _navigate(context, screenName),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: title == "Chat" ? Colors.blue : Colors.black12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icon, size: 30),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(subtitle, style: const TextStyle(fontSize: 12)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        backgroundColor: Colors.black87,
        actions: const [
          Icon(Icons.notifications_none),
          SizedBox(width: 12),
          Icon(Icons.account_circle),
          SizedBox(width: 12),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.black87),
              child: Text('PathNova Admin', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            ListTile(leading: Icon(Icons.dashboard), title: Text('Dashboard')),
            ListTile(leading: Icon(Icons.settings), title: Text('Settings')),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildInfoCard("Pending Tasks", Icons.assignment, "2"),
                const SizedBox(width: 12),
                _buildInfoCard("Announcements", Icons.campaign_outlined, "12"),
              ],
            ),
            const SizedBox(height: 16),
            const Text("+Quick Actions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const Text("Common administrative tasks", style: TextStyle(fontSize: 13)),
            const SizedBox(height: 12),
            _buildQuickAction(
              context,
              Icons.group_outlined,
              "Manage Students",
              "View, add, or remove students",
              "Manage Students",
            ),
            _buildQuickAction(
              context,
              Icons.campaign_outlined,
              "Create Announcement",
              "Post new announcements",
              "Create Announcement",
            ),
            _buildQuickAction(
              context,
              Icons.chat_bubble_outline,
              "Chat",
              "Message or create a group",
              "Chat",
            ),
            _buildQuickAction(
              context,
              Icons.task_alt,
              "Assign Tasks",
              "Create and assign new tasks",
              "Assign Tasks",
            ),
            _buildQuickAction(
              context,
              Icons.person_add_alt,
              "Add Student",
              "Register new student",
              "Add Student",
            ),
          ],
        ),
      ),
    );
  }
}
