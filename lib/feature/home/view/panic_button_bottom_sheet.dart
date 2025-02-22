import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'dart:async';
import 'dart:math';

import 'package:quit_gambling/feature/home/view/dont_relapse_view.dart';
import 'package:quit_gambling/feature/relapsed/view/relapsed_view.dart';

class PanicButtonBottomSheet extends StatefulWidget {
  const PanicButtonBottomSheet({super.key});

  @override
  State<PanicButtonBottomSheet> createState() => _PanicButtonBottomSheetState();
}

class _PanicButtonBottomSheetState extends State<PanicButtonBottomSheet> {
  String _currentText = '';
  int _currentIndex = 0;

  // Motivational paragraphs about quitting gambling, each containing several sentences
  final List<List<String>> _motivationalParagraphs = [
    [
      "Every bet you avoid is a victory.",
      "Your strength grows with each passing day.",
      "Financial freedom awaits you on this path.",
      "You're building a better future with each choice."
    ],
    [
      "Gambling promises wealth but delivers poverty.",
      "Your life has more value than any bet could offer.",
      "Recovery happens one day at a time.",
      "Each moment of resistance makes you stronger."
    ],
    [
      "The house always wins in the long run.",
      "But you can win your life back starting now.",
      "Your family and friends need the real you.",
      "Choose yourself over the false promise of easy money."
    ],
    [
      "Your mind deserves peace, not gambling anxiety.",
      "Every urge defeated is a battle won.",
      "You are worth more than your last loss or win.",
      "Real happiness comes from connections, not cards or dice."
    ],
    [
      "Gambling steals your time, money, and dignity.",
      "You have the power to break this cycle today.",
      "Each clean day is an investment in your future.",
      "Your potential is greater than any jackpot."
    ]
  ];

  int _currentParagraphIndex = 0;
  int _currentSentenceIndex = 0;
  bool _isAnimating = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Select a random paragraph to show on each opening
    _currentParagraphIndex = Random().nextInt(_motivationalParagraphs.length);
    _startSentenceAnimation();
  }

  void _startSentenceAnimation() {
    _timer?.cancel();
    _currentText = '';
    _currentIndex = 0;
    _isAnimating = true;

    // Get the current sentence being animated
    String currentSentence =
        _motivationalParagraphs[_currentParagraphIndex][_currentSentenceIndex];

    // Start the animation for the current sentence
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_currentIndex < currentSentence.length) {
        setState(() {
          _currentText = currentSentence.substring(0, _currentIndex + 1);
          _currentIndex++;
          // Add haptic feedback for each character
          HapticFeedback.mediumImpact();
        });
      } else {
        // Sentence animation completed - wait before moving to next sentence
        _timer?.cancel();
        _isAnimating = false;

        // If there are more sentences in this paragraph, schedule the next one
        if (_currentSentenceIndex <
            _motivationalParagraphs[_currentParagraphIndex].length - 1) {
          Future.delayed(const Duration(milliseconds: 800), () {
            setState(() {
              _currentSentenceIndex++;
              _startSentenceAnimation();
            });
          });
        } else {
          // If we've completed all sentences in this paragraph, we're done
          // In a real app, you might want to loop or reset after some time
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.sized.height * 0.94,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Fixed app bar section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: [
                // Handle bar
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
                const SizedBox(height: 16),
                // App Logo
                const Text(
                  'QUITBET',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),

                // Panic Button Text
                const Text(
                  'Panic Button',
                  style: TextStyle(
                    color: Color(0xfffd4539),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),

          // Scrollable middle content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  // Modified animated text section with sentence-by-sentence animation
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: AnimatedOpacity(
                        opacity: _isAnimating ? 1.0 : 0.8,
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          _currentText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center, // Center the text
                          overflow: TextOverflow.visible, // Don't clip the text
                          softWrap: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Side Effects Title
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Side effects of Relapsing:',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Side Effects List
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff050505),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xff131313),
                          width: 1,
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            SideEffectItem(
                              icon: Icons.attach_money,
                              title: 'FINANCIAL RUIN',
                              description: 'Growing debt and lost savings.',
                            ),
                            SizedBox(height: 24),
                            SideEffectItem(
                              icon: Icons.people_alt_outlined,
                              title: 'BROKEN RELATIONSHIPS',
                              description: 'Loss of trust from loved ones.',
                            ),
                            SizedBox(height: 24),
                            SideEffectItem(
                              icon: Icons.mood_bad,
                              title: 'MENTAL HEALTH DECLINE',
                              description: 'Increased anxiety and depression.',
                            ),
                            SizedBox(height: 24),
                            SideEffectItem(
                              icon: Icons.work_off,
                              title: 'CAREER DAMAGE',
                              description:
                                  'Poor performance and job loss risk.',
                            ),
                            SizedBox(height: 24),
                            SideEffectItem(
                              icon: Icons.person_off,
                              title: 'SOCIAL ISOLATION',
                              description:
                                  'Withdrawal from social\ninteractions.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Fixed bottom buttons
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // I Relapsed Button
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff180705),
                    borderRadius: context.border.highBorderRadius,
                  ),
                  child: CupertinoButton(
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.hand_thumbsdown,
                          color: Color(0xfff94439),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'I Relapsed',
                          style: TextStyle(
                            color: Color(0xfff94439),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const RelapsedView(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // I'm thinking of relapsing Button
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xfffe4538),
                    borderRadius: context.border.highBorderRadius,
                  ),
                  child: CupertinoButton(
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "I'm thinking of relapsing",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const DontRelapseView(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          context.sized.emptySizedHeightBoxLow3x,
        ],
      ),
    );
  }
}

class SideEffectItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const SideEffectItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
