import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:quit_gambling/feature/onboard/view/referral_code_view.dart';
import 'package:quit_gambling/product/constant/theme_constants.dart';

class ChooseYourGoals extends StatefulWidget {
  const ChooseYourGoals({super.key});

  @override
  State<ChooseYourGoals> createState() => _ChooseYourGoalsState();
}

class _ChooseYourGoalsState extends State<ChooseYourGoals> {
  final Map<String, bool> goals = {
    'Stronger relationships': false,
    'Improved self-confidence': false,
    'Improved mood and happiness': false,
    'More energy and motivation': false,
    'Improved self-control': false,
    'Improved focus and clarity': false,
    'Pure and healthy thoughts': false,
  };
  final Map<String, Color> iconColors = {
    'Stronger relationships': const Color(0xfffd0158),
    'Improved self-confidence': const Color(0xff0086fe),
    'Improved mood and happiness': const Color(0xfffed403),
    'More energy and motivation': const Color(0xfffe9a02),
    'Improved self-control': const Color(0xff16d7fa),
    'Improved focus and clarity': const Color(0xffd24ffa),
    'Pure and healthy thoughts': const Color(0xff30d158),
  };

  final Map<String, dynamic> goalIcons = {
    'Stronger relationships': Icons.favorite,
    'Improved self-confidence': CupertinoIcons.person_fill,
    'Improved mood and happiness': Icons.sentiment_satisfied,
    'More energy and motivation': Icons.bolt,
    'Improved self-control': 'assets/images/brain.png',
    'Improved focus and clarity': Icons.track_changes,
    'Pure and healthy thoughts': CupertinoIcons.sparkles,
  };

  // Unselected (darker) colors
  final Map<String, Color> unselectedColors = {
    'Stronger relationships': const Color(0xff50142a),
    'Improved self-confidence': const Color(0xff052a58),
    'Improved mood and happiness': const Color(0xff4f410c),
    'More energy and motivation': const Color(0xff4d310b),
    'Improved self-control': const Color(0xff1e4053),
    'Improved focus and clarity': const Color(0xff3b1a4d),
    'Pure and healthy thoughts': const Color(0xff0f3f1e),
  };

  // Selected (lighter) colors
  final Map<String, Color> selectedColors = {
    'Stronger relationships': const Color(0xff831f39),
    'Improved self-confidence': const Color(0xff074587),
    'Improved mood and happiness': const Color(0xff806c0c),
    'More energy and motivation': const Color(0xff80510a),
    'Improved self-control': const Color(0xff326882),
    'Improved focus and clarity': const Color(0xff612c7b),
    'Pure and healthy thoughts': const Color(0xff18692f),
  };

  final Map<String, bool> pressedStates = {};
  Widget _buildGoalItem(String goal) {
    final bool isSelected = goals[goal] ?? false;
    final bool isPressed = pressedStates[goal] ?? false;
    final Color backgroundColor =
        isSelected ? selectedColors[goal]! : unselectedColors[goal]!;

    return GestureDetector(
      onTapDown: (_) => setState(() => pressedStates[goal] = true),
      onTapUp: (_) => setState(() => pressedStates[goal] = false),
      onTapCancel: () => setState(() => pressedStates[goal] = false),
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() {
          goals[goal] = !isSelected;
        });
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 50),
        opacity: isPressed ? 0.5 : 1.0,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: isPressed
                ? backgroundColor.withBlue((backgroundColor.blue * 0.8).round())
                : backgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: iconColors[goal],
                  child: goalIcons[goal] is IconData
                      ? Icon(
                          goalIcons[goal],
                          color: Colors.white,
                          size: 20,
                        )
                      : Image.asset(
                          goalIcons[goal],
                          width: 20,
                          height: 20,
                          color: Colors.white,
                        ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    goal,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? Colors.white : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : Colors.white.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                          CupertinoIcons.checkmark,
                          size: 14,
                          color: Colors.black,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: ThemeConstants().getBackgroundLinearGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              Padding(
                padding: context.padding.onlyLeftNormal,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              context.sized.emptySizedHeightBoxLow,
              // Title and Subtitle
              Padding(
                padding: context.padding.onlyLeftNormal,
                child: const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Choose your goals',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Scrollable Goals List
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    Padding(
                      padding: context.padding.horizontalNormal,
                      child: Text(
                        'Select the goals you wish to track during your reboot.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                    context.sized.emptySizedHeightBoxLow3x,
                    ...goals.keys.map((goal) => _buildGoalItem(goal)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 48, left: 16, right: 16, top: 8),
          child: CupertinoButton(
            onPressed: () {
              HapticFeedback.lightImpact();

              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const ReferralCodeView(),
                ),
              );
            },
            color: Colors.white,
            borderRadius: context.border.highBorderRadius,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: const Text(
              "Track these goals",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
