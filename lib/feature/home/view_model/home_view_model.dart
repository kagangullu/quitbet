import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quit_gambling/feature/home/view/home_view.dart';
import 'package:quit_gambling/product/services/abstinence_tracker_service.dart';

mixin HomeViewModel on State<HomeView> {
  int selectedIndex = 0;

  String currentMood = 'happy';
  final AbstinenceTrackerService trackerService = AbstinenceTrackerService();
  Timer? _timer;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  DateTime? get startTime => trackerService.getStartTime();
  Duration get duration => trackerService.getAbstinenceDuration();
  int get brainProgress => trackerService.calculateBrainProgress();

  String calculateQuitDate() {
    if (trackerService.getStartTime() == null) {
      final now = DateTime.now();
      final target = now.add(const Duration(days: 90));
      return DateFormat('dd MMM yyyy').format(target);
    }

    // Calculate date 90 days after start time
    final startTime = trackerService.getStartTime()!;
    final quitDate = startTime.add(const Duration(days: 90));

    // Format the date as "Month Day, Year"
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    final month = months[quitDate.month - 1];
    final day = quitDate.day;
    final year = quitDate.year;

    return '$month $day, $year';
  }

  @override
  void initState() {
    super.initState();
    _initTrackerService();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _initTrackerService() async {
    setState(() => _isLoading = true);

    await trackerService.init();

    _startTimer();

    setState(() => _isLoading = false);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() {});
    });
  }

  Future<void> resetTracking() async {
    await trackerService.resetTracking();
    if (mounted) setState(() {});
  }

  final Map<String, String> moodEmojis = {
    'happy': '😄',
    'tired': '😴',
    'neutral': '😐',
    'worried': '😟',
    'sad': '😢',
  };
}
