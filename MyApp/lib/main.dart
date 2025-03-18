import 'package:flutter/material.dart';
import 'package:mobile_ass/Screens/Welcome/welcome_screen.dart';
import 'package:mobile_ass/Screens/Home/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Screens/Signup/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://liphpparbpvezjqqjthi.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxpcGhwcGFyYnB2ZXpqcXFqdGhpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDIyOTQyNDksImV4cCI6MjA1Nzg3MDI0OX0.aF639wBcHPkr1MSYSM_jUEsNqpXAvAPXO0lMXCelfPk',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}