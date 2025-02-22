import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';
import 'package:quit_gambling/feature/achievements/view/achievements_view.dart';
import 'package:quit_gambling/feature/home/view/dont_relapse_view.dart';
import 'package:quit_gambling/feature/home/view/meditate_view.dart';
import 'package:quit_gambling/feature/home/view_model/home_view_model.dart';
import 'package:quit_gambling/feature/home/widget/menu_section.dart';
import 'package:quit_gambling/feature/home/widget/mood_panel.dart';
import 'package:quit_gambling/feature/home/widget/pledge_bottom_sheet.dart';
import 'package:quit_gambling/feature/home/widget/quitting_reason_widget.dart';
import 'package:quit_gambling/feature/main_view.dart';
import 'package:quit_gambling/feature/relapsed/view/relapsed_view.dart';
import 'package:quit_gambling/product/constant/theme_constants.dart';
import 'package:quit_gambling/product/widget/join_group_dialog.dart';

part '../widget/action_button.dart';
part '../widget/status_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeViewModel {
  bool _isTempted = false;

  /// Determines which Lottie animation to display based on abstinence duration
  String _getLottieAssetPath() {
    final days = trackerService.getAbstinenceDuration().inDays;

    // Match the achievement milestones for consistency
    if (days >= 90) {
      return "assets/lottie/star.json"; // Nirvana
    } else if (days >= 60) {
      return "assets/lottie/dia_3.json"; // Ascendant
    } else if (days >= 45) {
      return "assets/lottie/dia_2.json"; // Trailblazer
    } else if (days >= 30) {
      return "assets/lottie/dia_1.json"; // Guardian
    } else if (days >= 14) {
      return "assets/lottie/orb_4.json"; // Fortress
    } else if (days >= 10) {
      return "assets/lottie/orb_3.json"; // Momentum
    } else if (days >= 7) {
      return "assets/lottie/orb_5.json"; // Pioneer
    } else if (days >= 3) {
      return "assets/lottie/orb_2.json"; // Sprout
    } else {
      return "assets/lottie/orb_1.json"; // Seed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: ThemeConstants().getBackgroundLinearGradient,
      ),
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: context.padding.horizontalNormal,
              child: Column(
                children: [
                  context.sized.emptySizedHeightBoxNormal,
                  context.sized.emptySizedHeightBoxLow,
                  context.sized.emptySizedHeightBoxLow,
                  Row(
                    children: [
                      const Text(
                        "QUITBET",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      const Icon(CupertinoIcons.money_dollar_circle),
                      context.sized.emptySizedWidthBoxLow3x,
                      //SVG icon
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AchievementsView(),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                        child: SvgPicture.asset(
                          "assets/icons/cup_icon.svg",
                          color: Colors.white,
                          height: 24,
                        ),
                      ),
                    ],
                  ),
                  context.sized.emptySizedHeightBoxLow,
                  Center(
                    child: Lottie.asset(
                      _getLottieAssetPath(),
                      height: 150,
                      repeat: true,
                      animate: true,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "You've been gambling-free for:",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    trackerService.getMainDurationText(),
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Builder(
                    builder: (context) {
                      final secondaryText =
                          trackerService.getSecondaryDurationText();
                      if (secondaryText.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xff11133c),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          secondaryText,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
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
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const RelapsedView(),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                        label: "Reset",
                        icon: Icons.refresh,
                      ),
                      _ActionButton(
                        onTap: () {
                          showCupertinoDialog<void>(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) =>
                                const JoinGroupDialog(),
                          );
                        },
                        label: "Chat",
                        icon: Icons.telegram,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _buildBrainProgressBar(),
                  context.sized.emptySizedHeightBoxLow3x,
                  Center(
                    child: Row(
                      children: [
                        StatusCard(
                          title: "You're on track to quit by:",
                          value: calculateQuitDate(),
                          iconOrEmoji: Icons.check_circle,
                          iconColor: Colors.white,
                          onTap: () {
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
                          textColor: Colors.white,
                          isEmoji: false,
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                        StatusCard(
                            title: 'Tempted to Relapse:',
                            value: _isTempted
                                .toString()
                                .replaceFirst('t', 'T')
                                .replaceFirst('f', 'F'),
                            iconOrEmoji: moodEmojis[currentMood] ?? '😁',
                            iconColor: const Color(0xFFFFD700),
                            onTap: () async {
                              await showModalBottomSheet(
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
                              if (context.mounted) {
                                if (_isTempted) {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          const DontRelapseView(),
                                      fullscreenDialog: true,
                                    ),
                                  );
                                }
                              }
                            },
                            textColor: _isTempted ? Colors.red : Colors.green,
                            isEmoji: true),
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

  Widget _buildBrainProgressBar() {
    return Container(
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
                value: brainProgress / 100,
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
            '$brainProgress%',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
