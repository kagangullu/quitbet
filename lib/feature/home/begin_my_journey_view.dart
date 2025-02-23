import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';
import 'package:quit_gambling/product/services/abstinence_tracker_service.dart';

class BeginMyJourneyView extends StatefulWidget {
  const BeginMyJourneyView({super.key});

  @override
  State<BeginMyJourneyView> createState() => _BeginMyJourneyViewState();
}

class _BeginMyJourneyViewState extends State<BeginMyJourneyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Lottie Background
          Positioned.fill(
            child: Lottie.asset(
              'assets/lottie/welcome_bg.json',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Text(
                  'QUITBET',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Welcome Text
                      const Text(
                        'Welcome to your',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Gambling-Free Journey',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Subtitle
                      const Text(
                        '#1 Science based gambling quitting app',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Laurel image
                      Image.asset(
                        'assets/images/laurel.png',
                        height: 60,
                      ),
                    ],
                  ),
                ),
                // Start Streak Button
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: context.border.highBorderRadius,
                    ),
                    child: Padding(
                      padding: context.padding.verticalLow / 2,
                      child: CupertinoButton(
                        onPressed: () async {
                          final trackerService = AbstinenceTrackerService();
                          await trackerService.startTracking();
                          if (context.mounted) {
                            Navigator.pop(context, true);
                          }
                        },
                        padding: EdgeInsets.zero,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.timer, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Start Streak',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
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
