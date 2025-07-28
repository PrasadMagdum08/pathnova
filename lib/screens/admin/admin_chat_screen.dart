import 'package:Pathnova/screens/components/chat_details_screen.dart' show ChatDetailScreen;
import 'package:flutter/material.dart';

class AdminChatScreen extends StatelessWidget {
  const AdminChatScreen({super.key});

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
        title: const Text('Admin Chats', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _chatCard(
            context,
            name: 'Prasad Magdum',
            role: 'student',
            isGroup: false,
            chatId: 'chat-student-prasad',
            chatType: 'student',
            lastMessage: 'Sir, can you help me with resume?',
            time: '5m ago',
          ),
          _chatCard(
            context,
            name: 'AI Club Team',
            role: 'group',
            isGroup: true,
            chatId: 'chat-group-ai-club',
            chatType: 'group',
            lastMessage: 'Meeting link updated!',
            time: '20m ago',
          ),
        ],
      ),
    );
  }

  Widget _chatCard(
    BuildContext context, {
    required String name,
    required String role,
    required bool isGroup,
    required String chatId,
    required String chatType,
    required String lastMessage,
    required String time,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatDetailScreen(
              name: name,
              role: role,
              chatId: chatId,
              chatType: chatType,
              isGroup: isGroup,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              child: Text(name[0]),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(lastMessage, style: const TextStyle(color: Colors.black54, fontSize: 13)),
                ],
              ),
            ),
            Text(time, style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
