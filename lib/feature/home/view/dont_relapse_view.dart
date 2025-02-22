import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:kartal/kartal.dart';
import 'package:url_launcher/url_launcher.dart';

class DontRelapseView extends StatefulWidget {
  const DontRelapseView({super.key});

  @override
  State<DontRelapseView> createState() => _DontRelapseViewState();
}

class _DontRelapseViewState extends State<DontRelapseView> {
  // Warning messages shown in red
  final List<String> _warningMessages = [
    "Excessive gambling can lead to financial devastation and bankruptcy.",
    "Gambling addiction destroys relationships and trust with loved ones.",
    "Compulsive gambling causes severe anxiety and depression.",
    "The temporary high of winning is not worth the lasting pain of addiction.",
    "Gambling triggers the same brain circuits as drug addiction.",
  ];

  // Motivational messages shown in white
  final List<String> _motivationalMessages = [
    "Your journey away from gambling is a journey towards financial freedom.",
    "Each day without gambling is a victory for your future self.",
    "Recovery is possible, and you're proving it with each clean day.",
    "Your value is not determined by wins or losses, but by your character.",
    "The strength to quit shows more courage than any bet ever could.",
  ];

  // Randomly select messages to display
  late String _currentWarning;
  late String _currentMotivation;

  @override
  void initState() {
    super.initState();
    // Select random messages on page load
    _currentWarning =
        _warningMessages[Random().nextInt(_warningMessages.length)];
    _currentMotivation =
        _motivationalMessages[Random().nextInt(_motivationalMessages.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Don't Relapse",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Warning message (in red)
                    Text(
                      _currentWarning,
                      style: const TextStyle(
                        color: Color(0xFFF94538),
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    Container(
                      height: 1,
                      color: Colors.grey[800],
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    const SizedBox(height: 40),
                    // Motivational message (in white)
                    Text(
                      _currentMotivation,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Bottom actions
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Talk in Chat button
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: CupertinoButton(
                    onPressed: () async {
                      final Uri url =
                          Uri.parse('https://t.me/+f-L9wmRlWNdiMmJk');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      }
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.waving_hand_outlined,
                          color: Colors.black,
                        ),
                        context.sized.emptySizedWidthBoxLow3x,
                        const Text(
                          "Talk in Chat",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // TextButton.icon(
                  //   icon: const Icon(
                  //     Icons.chat_bubble_outline,
                  //     color: Colors.black,
                  //   ),
                  //   label: const Text(
                  //     "Talk in Chat",
                  //     style: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     // Navigate to chat page
                  //   },
                  // ),
                ),

                // Breathing exercise text
                CupertinoButton(
                  onPressed: () {
                    // Navigate to breathing exercise
                  },
                  child: const Text(
                    "or Start Breathing Exercise",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
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
