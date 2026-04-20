import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widget/bottom_navbar.dart'; // Adjust path if needed

class MainScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
