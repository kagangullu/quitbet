import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';
import 'package:quit_gambling/feature/onboard/view/intoducing_app_view.dart';

class IntroducingOnboardView extends StatefulWidget {
  const IntroducingOnboardView({super.key});

  @override
  State<IntroducingOnboardView> createState() => _IntroducingOnboardViewState();
}

class _IntroducingOnboardViewState extends State<IntroducingOnboardView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingModel> _pages = [
    OnboardingModel(
      backgroundColor: const Color(0xffd8042b),
      lottieUrl: 'assets/lottie/brain.json',
      title: 'Porn is a drug',
      description:
          'Using porn releases a chemical in the brain called dopamine. This chemical makes you feel good- it\'s why you feel pleasure when you watch porn.',
    ),
    OnboardingModel(
      backgroundColor: const Color(0xffd8042b),
      lottieUrl: 'assets/lottie/relationship.json',
      title: 'Porn destroys relationships',
      description:
          'Porn reduces your hunger for a real relationship and replaces it with the hunger for more porn.',
    ),
    OnboardingModel(
      backgroundColor: const Color(0xffd8042b),
      lottieUrl: 'assets/lottie/unhappy.json',
      title: 'Feeling unhappy?',
      description:
          'An elevated dopamine level means you need more dopamine to feel good. This is why so many heavy porn users report feeling depressed, unmotivated, and anti-social.',
    ),
    OnboardingModel(
      backgroundColor: const Color(0xff033e8b),
      lottieUrl: 'assets/lottie/growth.json',
      title: 'Path to Recovery',
      description:
          'Recovery is possible. By abstaining from porn, your brain can reset its dopamine sensitivity, leading to healthier relationships and improved well-being.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPress() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => const IntroducingAppView(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pages[_currentPage].backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: context.padding.horizontalNormal,
          child: Column(
            children: [
              const SizedBox(height: 24),
              const Text(
                'BetOff',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          page.lottieUrl,
                          height: 225,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          page.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          page.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == _currentPage
                          ? Colors.white
                          : Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CupertinoButton(
                color: Colors.white,
                borderRadius: context.border.highBorderRadius,
                onPressed: _onNextPress,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Next",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    context.sized.emptySizedWidthBoxLow,
                    const Icon(
                      CupertinoIcons.chevron_right,
                      size: 20,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              context.sized.emptySizedHeightBoxLow,
            ],
          ),
        ),
      ),
    );
  }
}

// onboarding_model.dart
class OnboardingModel {
  final String lottieUrl;
  final String title;
  final String description;
  final Color backgroundColor;
  OnboardingModel({
    required this.backgroundColor,
    required this.lottieUrl,
    required this.title,
    required this.description,
  });
}
