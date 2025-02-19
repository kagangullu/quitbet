import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';
import 'package:quit_gambling/feature/home/view/meditate_view.dart';
import 'package:quit_gambling/feature/home/view_model/home_view_model.dart';
import 'package:quit_gambling/feature/home/widget/menu_section.dart';
import 'package:quit_gambling/feature/home/widget/mood_panel.dart';
import 'package:quit_gambling/feature/home/widget/pledge_bottom_sheet.dart';
import 'package:quit_gambling/feature/home/widget/quitting_reason_widget.dart';
import 'package:quit_gambling/feature/main_view.dart';
import 'package:quit_gambling/product/constant/theme_constants.dart';

part '../widget/action_button.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeViewModel {
  bool _isTempted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: ThemeConstants().getBackgroundLinearGradient,
      ),
      child: SingleChildScrollView(
        padding: context.padding.horizontalNormal,
        child: Column(
          children: [
            context.sized.emptySizedHeightBoxLow3x,
            context.sized.emptySizedHeightBoxLow3x,
            context.sized.emptySizedHeightBoxLow3x,
            Center(
              child: Lottie.asset("assets/lottie/orb.json", height: 175),
            ),
            const SizedBox(height: 30),
            const Text(
              "You've been gambling-free for:",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
            Text(
              startTime != null
                  ? '${DateTime.now().difference(startTime!).inDays} days'
                  : '0 days',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xff11133c),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                formatDuration(duration),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ActionButton(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const PledgeBottomSheet(),
                    );
                  },
                  label: "Pledge",
                  icon: Icons.back_hand,
                ),
                _ActionButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MeditateView(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  label: "Meditate",
                  icon: Icons.self_improvement,
                ),
                _ActionButton(
                  onTap: () {},
                  label: "Reset",
                  icon: Icons.refresh,
                ),
                _ActionButton(
                  onTap: () {},
                  label: "More",
                  icon: Icons.more_horiz,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xff051126),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xff012a51),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  const Text(
                    'Brain Rewiring',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: calculateProgress() / 100,
                        minHeight: 8,
                        backgroundColor: Colors.black26,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.teal.shade300,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${calculateProgress()}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            context.sized.emptySizedHeightBoxLow3x,
            Center(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildStatusCard(
                    "You're on track to quit by:",
                    'May 18, 2025',
                    Icons.check_circle,
                    Colors.white,
                    () {
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const MainView(selectedIndex: 1),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                    Colors.white,
                    isEmoji: false,
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  _buildStatusCard(
                    'Tempted to Relapse:',
                    _isTempted
                        .toString()
                        .replaceFirst('t', 'T')
                        .replaceFirst('f', 'F'),
                    moodEmojis[currentMood] ?? '😁',
                    const Color(0xFFFFD700),
                    () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => MoodPanel(
                          onSave: (mood, isTempted) {
                            setState(() {
                              currentMood = mood;
                              _isTempted = isTempted;
                            });
                          },
                        ),
                      );
                    },
                    _isTempted ? Colors.red : Colors.green,
                    isEmoji: true,
                  ),
                ],
              ),
            ),
            context.sized.emptySizedHeightBoxLow,
            context.sized.emptySizedHeightBoxLow,
            const QuitReasonCard(),
            context.sized.emptySizedHeightBoxLow,
            const MenuSection(),
            context.sized.emptySizedHeightBoxHigh,
            context.sized.emptySizedHeightBoxHigh,
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(
    String title,
    String value,
    dynamic iconOrEmoji,
    Color iconColor,
    VoidCallback onTap,
    Color textColor, {
    bool isEmoji = false,
  }) {
    return Expanded(
      flex: 12,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xff11133c),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF373737), width: 0.7),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: title.contains('track') ? 10 : 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -15,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Color(0xff11133c),
                  shape: BoxShape.circle,
                ),
                child: isEmoji
                    ? Text(
                        iconOrEmoji,
                        style: const TextStyle(fontSize: 30),
                      )
                    : Icon(
                        iconOrEmoji,
                        color: iconColor,
                        size: 36,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
