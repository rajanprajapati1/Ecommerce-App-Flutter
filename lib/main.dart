// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/app_theme_mode.dart';
import 'app/binding.dart';
import 'app/router.dart';
import 'app/theme.dart';

void main() {
  AppBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    return Obx(() => MaterialApp.router(
          title: 'E-Commerce Demo',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.themeMode.value,
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            return AppScaffold(child: child!);
          },
        ));
  }
}

class AppScaffold extends StatelessWidget {
  final Widget child;
  const AppScaffold({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = kIsWeb;
    final isWideScreen = screenWidth > 800;

    // Show normal mobile view on mobile devices or narrow screens
    if (!isWeb || !isWideScreen) {
      return child;
    }

    // Show centered layout with promo cards on web/desktop
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 36, 36),
      body: Row(
        children: [
          // Left promo card
          SizedBox(
            width: 180,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: PromoCardLeft(),
              ),
            ),
          ),
          // Center mobile view
          Expanded(
            child: Center(
              child: Container(
                width: 320, // typical mobile width
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 24,
                    ),
                  ],
                ),
                child: ClipRRect(
                  child: child,
                ),
              ),
            ),
          ),
          // Right promo card
          SizedBox(
            width: 180,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: PromoCardRight(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Example promo card widgets
class PromoCardLeft extends StatelessWidget {
  const PromoCardLeft({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Replace with your QR code or promo widget
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
              child: Text('QR', style: TextStyle(color: Colors.black))),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Download KNOT'),
        ),
      ],
    );
  }
}

class PromoCardRight extends StatelessWidget {
  const PromoCardRight({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Replace with your Instagram or promo widget
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.camera_alt, color: Colors.white, size: 40),
        ),
        const SizedBox(height: 8),
        const Text('Instagram', style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
