import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:kartal/kartal.dart';

class LottieRelaxingView extends StatefulWidget {
  const LottieRelaxingView({
    super.key,
    required this.title,
    required this.quotes,
    required this.lottieUrl,
    required this.textColor,
  });

  final String title;
  final List<String> quotes;
  final String lottieUrl;
  final Color textColor;

  @override
  State<LottieRelaxingView> createState() => _LottieRelaxingViewState();
}

class _LottieRelaxingViewState extends State<LottieRelaxingView>
    with SingleTickerProviderStateMixin {
  late List<String> _originalTexts;

  late List<String> _shuffledTexts;
  int currentIndex = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _originalTexts = widget.quotes;
    _shuffledTexts = List.from(_originalTexts)..shuffle();

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
        currentIndex = (currentIndex + 1) % _shuffledTexts.length;
        // Reshuffle when we reach the end
        if (currentIndex == 0) {
          _shuffledTexts.shuffle();
        }
      });

      // Fade in
      await _fadeController.reverse();

      _startAnimation();
    });
  }

  void _restartWithNewShuffle() async {
    await _fadeController.forward();

    setState(() {
      _shuffledTexts.shuffle();
      currentIndex = 0;
    });

    await _fadeController.reverse();
    _startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Lottie Background
          Positioned.fill(
            child: Lottie.asset(
              widget.lottieUrl,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                // App Bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),

                context.sized.emptySizedHeightBoxLow3x,

                // Animated Text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      _shuffledTexts[currentIndex],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: widget.textColor,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                  ),
                ),

                const Spacer(flex: 2),

                // Regenerate Button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: MyCupertinoButton(
                    hintText: 'Regenerate',
                    isActive: true,
                    onTap: _restartWithNewShuffle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyCupertinoButton extends StatefulWidget {
  const MyCupertinoButton({
    super.key,
    required this.hintText,
    required this.isActive,
    required this.onTap,
  });

  final String hintText;
  final bool isActive;
  final VoidCallback onTap;

  @override
  State<MyCupertinoButton> createState() => _MyCupertinoButtonState();
}

class _MyCupertinoButtonState extends State<MyCupertinoButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.isActive ? Colors.white : const Color(0xFF404040),
        borderRadius: context.border.highBorderRadius,
      ),
      child: CupertinoButton(
        onPressed: widget.isActive ? widget.onTap : null,
        color: widget.isActive ? Colors.white : const Color(0xFF404040),
        borderRadius: context.border.highBorderRadius,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              String.fromCharCode(CupertinoIcons.refresh_bold.codePoint),
              style: TextStyle(
                inherit: false,
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                fontFamily: CupertinoIcons.refresh_bold.fontFamily,
                package: CupertinoIcons.refresh_bold.fontPackage,
              ),
            ),
            context.sized.emptySizedWidthBoxLow,
            context.sized.emptySizedWidthBoxLow,
            context.sized.emptySizedWidthBoxLow,
            Text(
              widget.hintText,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
