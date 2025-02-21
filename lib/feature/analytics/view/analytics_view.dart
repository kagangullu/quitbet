import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "dart:math" as math;
import "package:kartal/kartal.dart";
import "package:quit_gambling/product/constant/theme_constants.dart";
import "package:quit_gambling/product/services/abstinence_tracker_service.dart";

class AnalyticsView extends StatefulWidget {
  const AnalyticsView({super.key});

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {
  late AbstinenceTrackerService _trackerService;
  int _recoveryPercentage = 0;
  String _daysStreak = "0";
  String _fullRecoveryDate = "";
  Map<String, double> _benefitProgressMap = {
    "Improved Confidence": 0.0,
    "Increased Self-Esteem": 0.0,
    "Mental Clarity": 0.0,
    "Increased Libido": 0.0,
    "Healthier Thoughts": 0.0,
  };

  @override
  void initState() {
    super.initState();
    _trackerService = AbstinenceTrackerService();
    _initializeTrackerService();
  }

  Future<void> _initializeTrackerService() async {
    await _trackerService.init();
    _updateRecoveryData();
  }

  void _updateRecoveryData() {
    if (!mounted) return;

    final startTime = _trackerService.getStartTime();
    if (startTime == null) return;

    final duration = _trackerService.getAbstinenceDuration();
    final days = duration.inDays;

    final percentage = ((days / 90) * 100).clamp(0, 100).round();

    final fullRecoveryDate = startTime.add(const Duration(days: 90));
    final formattedDate =
        "${_getMonthAbbreviation(fullRecoveryDate.month)} ${fullRecoveryDate.day}, ${fullRecoveryDate.year}";

    final Map<String, double> benefitProgress = {
      "Improved Confidence": (days / 60).clamp(0.0, 1.0),
      "Increased Self-Esteem": (days / 70).clamp(0.0, 1.0),
      "Mental Clarity": (days / 45).clamp(0.0, 1.0),
      "Increased Libido": (days / 40).clamp(0.0, 1.0),
      "Healthier Thoughts": (days / 80).clamp(0.0, 1.0),
    };

    setState(() {
      _recoveryPercentage = percentage;
      _daysStreak = days.toString();
      _fullRecoveryDate = formattedDate;
      _benefitProgressMap = benefitProgress;
    });
  }

  String _getMonthAbbreviation(int month) {
    const months = [
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
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: ThemeConstants().getBackgroundLinearGradient,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.sized.emptySizedHeightBoxLow3x,
              context.sized.emptySizedHeightBoxLow3x,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recovery",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Oğuz",
                        style: TextStyle(
                          color: Color(0xFF9899A1),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  CupertinoButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        const Text(
                          "Share",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        context.sized.emptySizedWidthBoxLow,
                        context.sized.emptySizedWidthBoxLow,
                        const Icon(
                          CupertinoIcons.share,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Center(
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GradientCircularProgressPainter(
                        progress: _recoveryPercentage / 100,
                        gradient: const LinearGradient(
                          colors: [Color(0xff2bc865), Color(0xff21c8b6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "RECOVERY",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "$_recoveryPercentage%",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 72,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "$_daysStreak DAY STREAK",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: context.padding.horizontalLow,
                child: _buildMotivationalText(),
              ),
              const SizedBox(height: 20),
              Center(
                child: Image.asset(
                  "assets/images/brain.png",
                  height: 30,
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "You're on track to:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              context.sized.emptySizedHeightBoxLow,
              context.sized.emptySizedHeightBoxLow,
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                      color: const Color(0xff08132b),
                      borderRadius: context.border.highBorderRadius,
                      border: Border.all(
                        color: const Color(0xff012e59),
                      )),
                  child: Text(
                    "Quit Porn by $_fullRecoveryDate",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              context.sized.emptySizedHeightBoxLow3x,
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xff11133d),
                  borderRadius: context.border.normalBorderRadius,
                ),
                child: Column(
                  children: [
                    BenefitItem(
                      icon: Icons.star_border,
                      title: "Improved Confidence",
                      description:
                          "As you distance yourself from porn, you'll gradually notice improved confidence, particularly in social situations and interactions with others.",
                      progress:
                          _benefitProgressMap["Improved Confidence"] ?? 0.0,
                    ),
                    BenefitItem(
                      icon: Icons.psychology,
                      title: "Increased Self-Esteem",
                      description:
                          "With time, overcoming porn addiction can lead to a more positive self-image and higher self-esteem, as you regain control over your life.",
                      progress:
                          _benefitProgressMap["Increased Self-Esteem"] ?? 0.0,
                    ),
                    BenefitItem(
                      icon: Icons.brightness_7,
                      title: "Mental Clarity",
                      description:
                          "After quitting porn, many people report a noticeable improvement in mental clarity, focus, and cognitive function within a couple of months.",
                      progress: _benefitProgressMap["Mental Clarity"] ?? 0.0,
                    ),
                    BenefitItem(
                      icon: Icons.trending_up,
                      title: "Increased Libido",
                      description:
                          "As your body and mind recover, you may experience a healthier libido and improved sexual performance after around 30-45 days.",
                      progress: _benefitProgressMap["Increased Libido"] ?? 0.0,
                    ),
                    BenefitItem(
                      icon: Icons.favorite_border,
                      title: "Healthier Thoughts",
                      description:
                          "Quitting porn allows for the development of healthier, more realistic perceptions of sex and relationships, which generally becomes evident after a few months.",
                      progress:
                          _benefitProgressMap["Healthier Thoughts"] ?? 0.0,
                    ),
                  ],
                ),
              ),
              context.sized.emptySizedHeightBoxHigh,
              context.sized.emptySizedHeightBoxHigh,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMotivationalText() {
    final days = int.tryParse(_daysStreak) ?? 0;

    if (days < 7) {
      return const Text(
        "The first week is the hardest. Every day you resist is building your mental strength. Focus on making it through today.",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      );
    } else if (days < 30) {
      return const Text(
        "The changes are becoming more noticeable now. You're not just breaking a habit; you're building a new, healthier life. Keep going, one day at a time.",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      );
    } else if (days < 60) {
      return const Text(
        "You've made it past the first month! Your brain is healing, and you're establishing new neural pathways. The benefits will only grow from here.",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      );
    } else if (days < 90) {
      return const Text(
        "You're in the home stretch now. Your dedication is inspiring. The habits you've formed during this journey will serve you well beyond the 90-day mark.",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      );
    } else {
      return const Text(
        "Congratulations on reaching 90 days! This is a significant milestone in your recovery. Remember that this journey continues, but you've proven your strength and commitment.",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      );
    }
  }
}

class GradientCircularProgressPainter extends StatelessWidget {
  final double progress;
  final LinearGradient gradient;

  const GradientCircularProgressPainter({
    super.key,
    required this.progress,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(300, 300),
      painter: _GradientCircularProgressPainter(
        progress: progress,
        gradient: gradient,
        backgroundColor: const Color(0xFF2A2B36),
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  final double progress;
  final LinearGradient gradient;
  final Color backgroundColor;

  _GradientCircularProgressPainter({
    required this.progress,
    required this.gradient,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2);
    const strokeWidth = 20.0;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius - strokeWidth / 2, backgroundPaint);

    final progressPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressRect =
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);
    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(progressRect, startAngle, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class BenefitItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final double progress;

  const BenefitItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 12),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Stack(
                    children: [
                      Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Container(
                        height: 4,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: progress,
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF0785fa), Color(0xFF7ed29e)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
