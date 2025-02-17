import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quit_gambling/feature/onboard/view/paywall_introducing_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin PaywallIntroducingViewModel on State<PaywallIntroducingView> {
  String userName = '';
  String targetDate = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _calculateTargetDate();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final fullName = prefs.getString('user_name') ?? 'User';
    setState(() {
      userName = fullName.split(' ')[0];
    });
  }

  void _calculateTargetDate() {
    final now = DateTime.now();
    final threeMonthsLater = DateTime(now.year, now.month + 3, now.day);
    setState(() {
      targetDate = DateFormat('MMM dd, yyyy').format(threeMonthsLater);
    });
  }

  final benefitItems = [
    {
      'icon': CupertinoIcons.bolt_fill,
      'text': 'Increased Energy',
      'color': const Color(0xff002c4a),
    },
    {
      'icon': CupertinoIcons.arrow_up_right_square_fill,
      'text': 'Increased Motivation',
      'color': const Color(0xff5d3e00),
    },
    {
      'icon': Icons.settings,
      'text': 'Improved Focus',
      'color': const Color(0xff004a2d),
    },
    {
      'icon': Icons.people,
      'text': 'Improved Relationships',
      'color': const Color(0xff620502),
    },
    {
      'icon': Icons.psychology,
      'text': 'Increased Confidence',
      'color': const Color(0xff535400),
    },
  ];
}
