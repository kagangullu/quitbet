import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:quit_gambling/feature/onboard/view/check_symptoms_view.dart';

class AnalysisCompleteView extends StatefulWidget {
  const AnalysisCompleteView({super.key});

  @override
  State<AnalysisCompleteView> createState() => _AnalysisCompleteViewState();
}

class _AnalysisCompleteViewState extends State<AnalysisCompleteView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Animasyonu başlat
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0B1E),
      body: SafeArea(
        child: Padding(
          padding: context.padding.horizontalNormal * 1.5,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Column(
                children: [
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Analysis Complete",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check,
                            color: Colors.black, size: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "We've got some news to break to you...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 36),
                  const Text(
                    "Your responses indicate a clear\ndependance on gambling*",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                      height: 56 +
                          (280 *
                              (1 -
                                  _animation
                                      .value))), // Grafik yüksekliğine göre dinamik boşluk
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildBar(
                        context,
                        280 * _animation.value, // Yükseklik animasyonu
                        const Color(0xffc00003),
                        "52%",
                        "Your Score",
                      ),
                      context.sized.emptySizedWidthBoxLow3x,
                      _buildBar(
                        context,
                        100 * _animation.value, // Yükseklik animasyonu
                        const Color(0xff2e9965),
                        "13%",
                        "Average",
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "39% ",
                        style: TextStyle(
                          color: Color(0xFFE63946),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "higher dependence on gambling 📉",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    "* This result is an indication only, not a medical diagnosis. For a definitive assessment, please contact your healthcare provider.",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 11,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    margin: const EdgeInsets.only(bottom: 32),
                    width: double.infinity,
                    child: CupertinoButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const CheckSymptomsView(),
                          ),
                        );
                      },
                      color: const Color(0xFF2563EB),
                      borderRadius: context.border.highBorderRadius,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 32),
                      child: const Text(
                        "Check your symptoms",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Column _buildBar(
    BuildContext context,
    double height,
    Color color,
    String percentage,
    String text,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: height,
          width: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: context.border.lowBorderRadius,
          ),
          child: Center(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: context.padding.onlyTopLow,
                child: Text(
                  percentage,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
