import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quit_gambling/feature/home/view/home_view.dart';

mixin HomeViewModel on State<HomeView> {
  int selectedIndex = 0;
  Timer? timer;
  Duration duration = const Duration();
  DateTime? startTime;
  String currentMood = 'happy';

  final Map<String, String> moodEmojis = {
    'happy': '😄',
    'tired': '😴',
    'neutral': '😐',
    'worried': '😟',
    'sad': '😢',
  };
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    startTime = DateTime.now();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        duration = DateTime.now().difference(startTime!);
      });
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '${hours}hr ${minutes}m ${seconds}s';
  }

  int calculateProgress() {
    if (startTime == null) return 0;
    final daysPassed = DateTime.now().difference(startTime!).inDays;
    return ((daysPassed / 90) * 100).round().clamp(0, 100);
  }
}
