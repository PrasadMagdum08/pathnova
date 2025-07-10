import 'package:Pathnova/screens/auth/login_screen.dart' show LoginScreen;
import 'package:Pathnova/screens/student/student_dashboard_screen.dart' show StudentDashboardScreen;
import 'package:Pathnova/screens/student/student_profile_screen.dart' show StudentProfileScreen;
import 'package:flutter/material.dart';
import 'package:Pathnova/services/auth_provider.dart' show AuthService;

// Import all screens here
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService().loadToken(); // Load stored JWT token
  runApp(const PathNovaApp());
}

class PathNovaApp extends StatelessWidget {
  const PathNovaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PathNova',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/student_dashboard': (context) => const StudentDashboardScreen(),
        // '/admin_dashboard': (context) => const AdminDashboard(),
        '/student_profile': (context) => const StudentProfileScreen(),
        // Add more routes as needed
      },
    );
  }
}
