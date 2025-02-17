import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:kartal/kartal.dart';
import 'package:quit_gambling/feature/onboard/view/paywall_introducing_view.dart';
import 'package:quit_gambling/product/constant/theme_constants.dart';

class GiveRatingView extends StatefulWidget {
  const GiveRatingView({super.key});

  @override
  State<GiveRatingView> createState() => _GiveRatingViewState();
}

class _GiveRatingViewState extends State<GiveRatingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16) + context.padding.verticalLow,
          child: Container(
            color: Colors.transparent,
            margin: context.padding.horizontalLow / 2 +
                context.padding.onlyBottomLow,
            width: double.infinity,
            child: CupertinoButton(
              onPressed: () async {
                HapticFeedback.lightImpact();
                InAppReview inAppReview = InAppReview.instance;

                if (await inAppReview.isAvailable()) {
                  inAppReview.requestReview();
                }

                await Future.delayed(const Duration(seconds: 5));

                if (context.mounted) {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const PaywallIntroducingView(),
                    ),
                  );
                }
              },
              color: Colors.white,
              borderRadius: context.border.highBorderRadius,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: const Text(
                "Next",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: ThemeConstants().getBackgroundLinearGradient,
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 16),

            // Back button
            Align(
              alignment: Alignment.centerLeft,
              child: SafeArea(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Title
            const Text(
              'Give us a rating',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            // Stars and laurels
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/laurel.png', height: 100),
              ],
            ),

            const SizedBox(height: 32),

            // Subtitle
            const Text(
              'This app was designed for people\nlike you.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 24),

            // User count
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Avatar circles
                Container(
                  height: 40,
                  width: 100,
                  alignment: Alignment.center,
                  child: Row(
                    children: List.generate(
                        3,
                        (index) => Expanded(
                              child: Align(
                                alignment: index == 0
                                    ? Alignment.centerRight
                                    : index == 1
                                        ? Alignment.center
                                        : Alignment.centerLeft,
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey,
                                  child:
                                      Icon(Icons.person, color: Colors.white),
                                ),
                              ),
                            )),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  '+ 100,000 people',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Reviews
            _buildReviewCard(
              'Michael Stevens',
              '@michaels',
              'QUITBET has been a lifesaver for me. The progress tracking and motivational notifications have kept me on track. I haven\'t watched porn in 3 months and feel more in control of my life.',
            ),

            const SizedBox(height: 16),

            _buildReviewCard(
              'Tony Coleman',
              '@tcoleman23',
              'I was skeptical at first, but QUITBET\'s panic button feature has helped me resist urges and stay committed to my goals.',
            ),
            const SizedBox(height: 16),
            _buildReviewCard(
              'Tony Coleman',
              '@tcoleman23',
              'I was skeptical at first, but QUITBET\'s panic button feature has helped me resist urges and stay committed to my goals.',
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewCard(String name, String username, String review) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16) + context.padding.verticalLow,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xff131421),
            Color(0xff0e0f18),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      username,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (index) => const Padding(
                    padding: EdgeInsets.only(left: 2),
                    child: Icon(
                      Icons.star,
                      color: Color(0xFFFFD700),
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
