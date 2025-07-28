// lib/services/chat_socket_service.dart

import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatSocketService {
  static final ChatSocketService _instance = ChatSocketService._internal();
  factory ChatSocketService() => _instance;

  ChatSocketService._internal();

  late IO.Socket socket;

  // 🔌 Connect to Socket.IO server with JWT token
  void connect(String token) {
    socket = IO.io(
      'https://pathnova-backend-1.onrender.com', // 🔁 Replace with your actual backend URL
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'auth': {
          'token': token, // 🔐 JWT from login
        },
      },
    );

    // Start connection
    socket.connect();

    socket.onConnect((_) {
      log('🟢 Connected to socket server');
    });

    socket.onDisconnect((_) {
      log('🔌 Disconnected from socket server');
    });

    socket.onConnectError((error) {
      log('❌ Socket connection error: $error');
    });

    socket.onError((error) {
      log('❗ Socket error: $error');
    });
  }

  // 📩 Listen for new messages
  void onMessage(void Function(Map<String, dynamic>) callback) {
    socket.on('receive_message', (data) {
      if (data != null && data is Map<String, dynamic>) {
        callback(data);
      }
    });
  }

  // 🧑‍💬 Send message
  void sendMessage({
    required String chatId,
    required String content,
  }) {
    socket.emit('send_message', {
      'chatId': chatId,
      'content': content,
    });
  }

  // 📝 Typing indicator
  void startTyping(String chatId) {
    socket.emit('typing', {'chatId': chatId});
  }

  // ⏹️ Stop typing indicator
  void stopTyping(String chatId) {
    socket.emit('stop_typing', {'chatId': chatId});
  }

  // 🔌 Disconnect from socket
  void disconnect() {
    socket.disconnect();
  }

  // 🧹 Clear all socket listeners
  void clearListeners() {
    socket.clearListeners();
  }
}
