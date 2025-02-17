import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_circular_progress_indicator/gradient_circular_progress_indicator.dart';
import 'package:quit_gambling/feature/onboard/view/analysis_complete_view.dart';
import 'package:quit_gambling/product/constant/theme_constants.dart';

class CalculatingView extends StatefulWidget {
  const CalculatingView({super.key});

  @override
  State<CalculatingView> createState() => _CalculatingViewState();
}

class _CalculatingViewState extends State<CalculatingView>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  double _progressValue = 0.0;
  int _lastVibrationPercent = 20; // Changed to start at 20%
  String _currentText = "Understanding responses";

  final List<String> _loadingTexts = [
    "Understanding responses",
    "Learning relapse triggers",
    "Building custom plan",
    "Finalizing"
  ];

  late AnimationController _textAnimationController;
  late Animation<double> _textOpacity;

  @override
  void initState() {
    super.initState();

    // Creating multiple animations for different speed segments
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 11), // Back to original duration
    )..addListener(() {
        setState(() {
          // Create non-linear progress
          double rawProgress = _controller.value;
          if (rawProgress < 0.3) {
            // Slower in the beginning
            _progressValue = rawProgress * 0.9;
          } else if (rawProgress < 0.7) {
            // Medium speed in the middle
            _progressValue = 0.27 + (rawProgress - 0.3) * 1.2;
          } else {
            // Fastest at the end
            _progressValue = 0.75 + (rawProgress - 0.7) * 1.4;
          }

          _progressValue = _progressValue.clamp(0.0, 1.0);
          _checkAndVibrate();
          _updateLoadingText();
        });
      });

    _textAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _textOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _textAnimationController, curve: Curves.easeInOut),
    );

    _startLoading();
  }

  void _checkAndVibrate() {
    int currentPercent = (_progressValue * 100).toInt();

    // Vibrate for each percent increase after 20%
    if (currentPercent > _lastVibrationPercent && currentPercent >= 20) {
      // Progressive haptic feedback intensity based on progress
      if (currentPercent < 30) {
        HapticFeedback.lightImpact();
      } else if (currentPercent < 80) {
        HapticFeedback.mediumImpact();
      } else {
        HapticFeedback.heavyImpact();
      }

      _lastVibrationPercent = currentPercent;
    }
  }

  // Rest of the code remains the same...
  void _updateLoadingText() {
    int progress = (_progressValue * 100).toInt();
    String newText = _loadingTexts[0];

    if (progress > 90) {
      newText = _loadingTexts[3];
    } else if (progress > 60) {
      newText = _loadingTexts[2];
    } else if (progress > 30) {
      newText = _loadingTexts[1];
    }

    if (newText != _currentText) {
      _textAnimationController.forward().then((_) {
        setState(() {
          _currentText = newText;
        });
        _textAnimationController.reverse();
      });
    }
  }

  void _startLoading() {
    _controller.forward().whenComplete(() {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => const AnalysisCompleteView(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _textAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: ThemeConstants().getBackgroundLinearGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    GradientCircularProgressIndicator(
                      size: 200,
                      progress: _progressValue,
                      gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.green],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      backgroundColor: const Color(0xff201d20),
                      child: Center(
                        child: Text(
                          '${(_progressValue * 100).toInt()}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Calculating',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              FadeTransition(
                opacity: _textOpacity,
                child: Text(
                  _currentText,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
