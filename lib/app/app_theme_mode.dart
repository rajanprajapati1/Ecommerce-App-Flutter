// ignore_for_file: unreachable_switch_default

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { system, light, dark }

class ThemeController extends GetxController {
  static const _key = 'theme_mode';
  final themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_key) ?? 'system';
    switch (value) {
      case 'light':
        themeMode.value = ThemeMode.light;
        break;
      case 'dark':
        themeMode.value = ThemeMode.dark;
        break;
      default:
        themeMode.value = ThemeMode.system;
    }
  }

  void _updateSystemChrome(ThemeMode themeMode) {
    late bool isDark;

    switch (themeMode) {
      case ThemeMode.light:
        isDark = false;
        break;
      case ThemeMode.dark:
        isDark = true;
        break;
      case ThemeMode.system:
        isDark =
            WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.dark;
        break;
    }

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor:
            isDark ? const Color(0xFF181A20) : const Color(0xFFF8F9FA),
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
  }

  Future<void> setTheme(AppThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    ThemeMode themeMode;

    switch (mode) {
      case AppThemeMode.light:
        themeMode = ThemeMode.light;
        await prefs.setString(_key, 'light');
        break;
      case AppThemeMode.dark:
        themeMode = ThemeMode.dark;
        await prefs.setString(_key, 'dark');
        break;
      case AppThemeMode.system:
      default:
        themeMode = ThemeMode.system;
        await prefs.setString(_key, 'system');
    }

    this.themeMode.value = themeMode;
    _updateSystemChrome(themeMode);
  }

  void updateSystemChromeForCurrentTheme() {
    _updateSystemChrome(themeMode.value);
  }
}
