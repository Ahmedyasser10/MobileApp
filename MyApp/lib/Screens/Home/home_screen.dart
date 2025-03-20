import 'package:flutter/material.dart';
import 'package:mobile_ass/Screens/Buttom_Navigation_Bar/buttom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}