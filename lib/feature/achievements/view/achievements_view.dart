import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quit_gambling/product/constant/theme_constants.dart';
import 'package:quit_gambling/product/services/abstinence_tracker_service.dart';

class AchievementsView extends StatefulWidget {
  const AchievementsView({super.key});

  @override
  State<AchievementsView> createState() => _AchievementsViewState();
}

class _AchievementsViewState extends State<AchievementsView> {
  final AbstinenceTrackerService _trackerService = AbstinenceTrackerService();
  int _abstinenceDays = 0;

  @override
  void initState() {
    super.initState();
    _initializeTrackerService();
  }

  Future<void> _initializeTrackerService() async {
    await _trackerService.init();
    _updateAbstinenceDays();
  }

  void _updateAbstinenceDays() {
    final Duration duration = _trackerService.getAbstinenceDuration();
    setState(() {
      _abstinenceDays = duration.inDays;
    });
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
              _buildAppBar(),
              Expanded(
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  children: [
                    _buildShowcaseHeader(),
                    const SizedBox(height: 20),
                    _buildAchievementGrid(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const SizedBox(
              width: 48,
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
          const Text(
            'Achievements',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Empty SizedBox with the same width as the back button
          // to maintain proper centering of the title
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildShowcaseHeader() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Showcase',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Oğuz · ${_trackerService.getMainDurationText()} clean',
              style: const TextStyle(
                color: Color(0xFF8E8E9A),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Spacer(),
        Image.asset(
          "assets/images/laurel.png",
          height: 40,
        ),
      ],
    );
  }

  Widget _buildAchievementGrid() {
    final achievements = [
      Achievement(
        name: 'Seed',
        description:
            'Plant the seed of self-control by staying clean for 1 day.',
        days: 1,
        icon: 'assets/lottie/orb_1.json',
      ),
      Achievement(
        name: 'Sprout',
        description: 'Nurture your discipline by staying clean for 3 days.',
        days: 3,
        icon: 'assets/lottie/orb_2.json',
      ),
      Achievement(
        name: 'Pioneer',
        description: 'Become a pioneer of change by staying clean for 7 days.',
        days: 7,
        icon: 'assets/lottie/orb_5.json',
      ),
      Achievement(
        name: 'Momentum',
        description: 'Build unstoppable momentum by staying clean for 10 days.',
        days: 10,
        icon: 'assets/lottie/orb_3.json',
      ),
      Achievement(
        name: 'Fortress',
        description: 'Fortify your resolve by staying clean for 14 days.',
        days: 14,
        icon: 'assets/lottie/orb_4.json',
      ),
      Achievement(
        name: 'Guardian',
        description:
            'Guard your progress with strength by staying clean for 30 days.',
        days: 30,
        icon: 'assets/lottie/dia_1.json',
      ),
      Achievement(
        name: 'Trailblazer',
        description:
            'Become a warrior of self-discipline by staying clean for 45 days.',
        days: 45,
        icon: 'assets/lottie/dia_2.json',
      ),
      Achievement(
        name: 'Ascendant',
        description: 'Master your impulses through dedication for 60 days.',
        days: 60,
        icon: 'assets/lottie/dia_3.json',
      ),
      Achievement(
        name: 'Nirvana',
        description:
            'Achieve inner peace and liberation by staying clean for 90 days.',
        days: 90,
        icon: 'assets/lottie/star.json',
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final achievement = achievements[index];
        final int currentProgress = _abstinenceDays.clamp(0, achievement.days);
        final bool isCompleted = currentProgress >= achievement.days;
        return _buildAchievementCard(achievement, currentProgress, isCompleted);
      },
    );
  }

  Widget _buildAchievementCard(
      Achievement achievement, int currentProgress, bool isCompleted) {
    final double progressValue = achievement.days > 0
        ? (currentProgress / achievement.days).clamp(0.0, 1.0)
        : 0.0;

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xff1c1a35),
            Color(0xff13131f),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCompleted ? const Color(0xFF2A79FF) : Colors.grey.shade800,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                if (isCompleted)
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Lottie.asset(
                      achievement.icon,
                      repeat: true,
                      animate: isCompleted,
                    ),
                  ),
                if (!isCompleted)
                  const Icon(
                    Icons.lock,
                    color: Colors.grey,
                    size: 40,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              achievement.name,
              style: TextStyle(
                color: isCompleted ? Colors.white : Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              achievement.description,
              style: TextStyle(
                color: isCompleted ? Colors.white : Colors.grey.shade600,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progressValue,
                backgroundColor: Colors.grey.shade800,
                color: const Color(0xff2fcf56),
                minHeight: 5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$currentProgress/${achievement.days} days',
              style: TextStyle(
                color: isCompleted ? Colors.white70 : Colors.grey.shade600,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class Achievement {
  final String name;
  final String description;
  final int days;
  final String icon;

  Achievement({
    required this.name,
    required this.description,
    required this.days,
    required this.icon,
  });
}
