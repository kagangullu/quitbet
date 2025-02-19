import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "dart:math" as math;
import "package:kartal/kartal.dart";
import "package:quit_gambling/product/constant/theme_constants.dart";

class AnalyticsView extends StatefulWidget {
  const AnalyticsView({super.key});

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {
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
              const Center(
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GradientCircularProgressPainter(
                        progress: 0.39,
                        gradient: LinearGradient(
                          colors: [Color(0xff2bc865), Color(0xff21c8b6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "RECOVERY",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "37%",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 72,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "34 DAY STREAK",
                            style: TextStyle(
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
                child: const Text(
                  "The changes are becoming more noticeable now. You're not just breaking a habit; you're building a new, healthier life. Keep going, one day at a time.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
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
                  child: const Text(
                    "Quit Porn by Apr 16, 2025",
                    style: TextStyle(
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
                child: const Column(
                  children: [
                    BenefitItem(
                      icon: Icons.star_border,
                      title: "Improved Confidence",
                      description:
                          "As you distance yourself from porn, you'll gradually notice improved confidence, particularly in social situations and interactions with others.",
                      progress: 0.7,
                    ),
                    BenefitItem(
                      icon: Icons.psychology,
                      title: "Increased Self-Esteem",
                      description:
                          "With time, overcoming porn addiction can lead to a more positive self-image and higher self-esteem, as you regain control over your life.",
                      progress: 0.6,
                    ),
                    BenefitItem(
                      icon: Icons.brightness_7,
                      title: "Mental Clarity",
                      description:
                          "After quitting porn, many people report a noticeable improvement in mental clarity, focus, and cognitive function within a couple of months.",
                      progress: 0.5,
                    ),
                    BenefitItem(
                      icon: Icons.trending_up,
                      title: "Increased Libido",
                      description:
                          "As your body and mind recover, you may experience a healthier libido and improved sexual performance after around 30-45 days.",
                      progress: 0.65,
                    ),
                    BenefitItem(
                      icon: Icons.favorite_border,
                      title: "Healthier Thoughts",
                      description:
                          "Quitting porn allows for the development of healthier, more realistic perceptions of sex and relationships, which generally becomes evident after a few months.",
                      progress: 0.4,
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

    // Draw background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius - strokeWidth / 2, backgroundPaint);

    // Draw progress arc with gradient
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
                      // Gray background progress bar
                      Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[700], // Gray background
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      // Colored progress bar
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
