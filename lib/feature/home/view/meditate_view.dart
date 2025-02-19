import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quit_gambling/product/widget/my_cupertino_button.dart';

class MeditateView extends StatefulWidget {
  const MeditateView({super.key});

  @override
  State<MeditateView> createState() => _MeditateViewState();
}

class _MeditateViewState extends State<MeditateView>
    with SingleTickerProviderStateMixin {
  final List<String> reflections = [
    'Porn may feel like a quick comfort, but it takes you further from the real connection you crave.',
    'Your habits shape who you become tomorrow.',
    'Small steps forward are still progress.',
    'You are stronger than your urges.',
    'Real connections bring lasting happiness.',
  ];

  int currentIndex = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _startAnimation();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    Future.delayed(const Duration(seconds: 5), () async {
      if (!mounted) return;

      // Fade out
      await _fadeController.forward();

      setState(() {
        currentIndex = (currentIndex + 1) % reflections.length;
      });

      // Fade in
      await _fadeController.reverse();

      _startAnimation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1B35),
      body: Stack(
        children: [
          // Lottie Background
          Positioned.fill(
            child: Lottie.asset(
              'assets/lottie/bg.json',
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Spacer(flex: 1),

                  // Static Header
                  const Text(
                    'REFLECT AND BREATHE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Animated Text
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      reflections[currentIndex],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                  ),

                  const Spacer(flex: 2),

                  // Finish Button
                  SizedBox(
                    width: double.infinity,
                    child: MyCupertinoButton(
                      hintText: "Finish Reflecting",
                      isActive: true,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
