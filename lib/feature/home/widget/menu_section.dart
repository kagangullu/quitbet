import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:quit_gambling/feature/achievements/view/achievements_view.dart';
import 'package:quit_gambling/feature/home/view/lottie_relaxing_view.dart';
import 'package:quit_gambling/feature/reason_for_change/view/reason_for_change_view.dart';
import 'package:quit_gambling/product/widget/join_group_dialog.dart';

class MenuSection extends StatefulWidget {
  const MenuSection({super.key});

  @override
  State<MenuSection> createState() => _MenuSectionState();
}

class _MenuSectionState extends State<MenuSection> {
  void showJoinGroupDialog(BuildContext context) {
    showCupertinoDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => const JoinGroupDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSection(
          'Main',
          [
            _MenuItem(
              icon: const Icon(CupertinoIcons.bubble_left_bubble_right_fill,
                  size: 24),
              title: 'Talk to Melius',
              iconColor: Colors.orange,
              onTap: () {},
            ),
            _MenuItem(
              icon: const Icon(CupertinoIcons.heart_circle_fill, size: 24),
              title: 'Reasons for change',
              iconColor: Colors.pink,
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const ReasonsForChangeView(),
                    fullscreenDialog: true,
                  ),
                );
              },
            ),
            _MenuItem(
              icon: const Icon(CupertinoIcons.chat_bubble_2_fill, size: 24),
              title: 'Chat',
              iconColor: Colors.green,
              onTap: () {
                showJoinGroupDialog(context);
              },
            ),
            _MenuItem(
              icon: const Icon(CupertinoIcons.book_fill, size: 24),
              title: 'Learn',
              iconColor: Colors.orange,
              onTap: () {},
            ),
            _MenuItem(
              icon: const Icon(CupertinoIcons.tropicalstorm, size: 24),
              title: 'Achievements',
              iconColor: Colors.purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AchievementsView(),
                    fullscreenDialog: true,
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildSection(
          'Mindfulness',
          [
            _MenuItem(
              icon: const Icon(CupertinoIcons.headphones, size: 24),
              title: 'Side Effects',
              iconColor: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LottieRelaxingView(
                      lottieUrl: "assets/lottie/bg_side_effects.json",
                      title: "Side Effects",
                      textColor: Colors.white,
                      quotes: [
                        'Gambling addiction can lead to severe financial problems beyond monetary losses.',
                        'Regular gambling may cause increased anxiety and depression symptoms.',
                        'Compulsive gambling often affects sleep patterns and overall well-being.',
                        'Problem gambling can strain relationships with family and friends.',
                        'Online gambling might trigger dopamine responses similar to substance addiction.',
                        'Excessive gambling frequently leads to isolation from social connections.',
                        'Problem gamblers often experience difficulties maintaining work performance.',
                        'Gambling addiction can result in persistent stress and emotional instability.',
                        'Compulsive betting may lead to neglecting personal and professional responsibilities.',
                        'Recovery from gambling addiction requires commitment and support systems.',
                      ],
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
            ),
            _MenuItem(
              icon: const Icon(CupertinoIcons.list_bullet_below_rectangle,
                  size: 24),
              title: 'Motivation',
              iconColor: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LottieRelaxingView(
                      lottieUrl: "assets/lottie/motivation_lottie_bg.json",
                      title: "Motivation",
                      textColor: Colors.black,
                      quotes: [
                        'Every day without gambling is a victory worth celebrating.',
                        'Your future self will thank you for the changes you make today.',
                        'Recovery is not a race - take it one moment at a time.',
                        'You are stronger than the urge to gamble.',
                        'Financial freedom starts with breaking free from betting.',
                        'Replace the thrill of gambling with the peace of stability.',
                        'Your worth is not measured by wins or losses.',
                        'Each moment of resistance builds a stronger tomorrow.',
                        'True happiness comes from within, not from gambling.',
                        'You have the power to rewrite your story today.',
                        'Focus on progress, not perfection in recovery.',
                        'Gambling promises wealth but delivers chaos.',
                        'Your family deserves the best version of you.',
                        'Break free from the cycle - you are not your addiction.',
                        'Small steps forward create lasting change.',
                      ],
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
            ),
            _MenuItem(
              icon: const Icon(CupertinoIcons.wind, size: 24),
              title: 'Breath Exercise',
              iconColor: Colors.orange,
              onTap: () {},
            ),
            _MenuItem(
              icon: const Icon(CupertinoIcons.person_2_fill, size: 24),
              title: 'Success Stories',
              iconColor: Colors.yellow,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF11133C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF373737), width: 0.7),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ...items,
        ],
      ),
    );
  }
}

class _MenuItem extends StatefulWidget {
  final Widget icon;
  final String title;
  final Color iconColor;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.onTap,
  });

  @override
  State<_MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<_MenuItem> {
  bool isPressing = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: widget.onTap,
        onTapDown: (details) {
          setState(() {
            isPressing = true;
          });
        },
        onTapCancel: () {
          setState(() {
            isPressing = false;
          });
        },
        onTapUp: (details) {
          setState(() {
            isPressing = false;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              IconTheme(
                data: IconThemeData(
                    color: isPressing
                        ? widget.iconColor.withOpacity(.5)
                        : widget.iconColor),
                child: widget.icon,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: isPressing
                        ? Colors.white.withOpacity(.5)
                        : Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: isPressing
                    ? const Color.fromARGB(39, 255, 255, 255)
                    : Colors.white38,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
