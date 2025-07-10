import 'package:flutter/material.dart';

class StudentChatScreen extends StatelessWidget {
  const StudentChatScreen({super.key});

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
            const Text('Chats', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
                  hintText: 'Search chats, people or groups',
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
                      child: const Text('All', style: TextStyle(color: Colors.black)),
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
                      child: const Text('Groups', style: TextStyle(color: Colors.black)),
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
                      child: const Text('Personal', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _chatSection('Recent Chats', [
                _chatCard('Dr. Jane Smith', 'Mentor', 'Let\'s meet tomorrow at 10am.', '2m ago', true),
                _chatCard('Flutter Study Group', 'Group', 'Project deadline is next week.', '10m ago', false),
                _chatCard('John Doe', 'Student', 'Can you share the notes?', '1h ago', false),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chatSection(String title, List<Widget> chats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        ...chats,
      ],
    );
  }

  Widget _chatCard(String name, String role, String lastMessage, String time, bool unread) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black26),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blueGrey[100],
            child: Text(name[0], style: const TextStyle(color: Colors.black)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black26),
                      ),
                      child: Text(role, style: const TextStyle(fontSize: 11)),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(lastMessage, style: TextStyle(fontSize: 13, color: unread ? Colors.black : Colors.black54)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(time, style: const TextStyle(fontSize: 11, color: Colors.black54)),
              if (unread)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}