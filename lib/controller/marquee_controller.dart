// Controller to manage global pause/resume for all marquees

import 'package:flutter/material.dart';

import '../home/home_screen.dart';

class MarqueeController extends ValueNotifier<bool> {
  MarqueeController() : super(false);

  void pause() => value = true;
  void resume() => value = false;

  // Registry for all marquees
  static final List<AutoMarqueeState> _marquees = [];

  static void register(AutoMarqueeState state) {
    _marquees.add(state);
  }

  static void unregister(AutoMarqueeState state) {
    _marquees.remove(state);
  }

  static void pauseAll() {
    for (final m in _marquees) {
      m.pause();
    }
  }

  static void resumeAll() {
    for (final m in _marquees) {
      m.resume();
    }
  }
}
