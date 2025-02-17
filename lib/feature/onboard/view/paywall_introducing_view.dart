import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:quit_gambling/feature/onboard/view_model/paywall_introducing_view_model.dart';
import 'package:quit_gambling/feature/onboard/widget/discount_card.dart';
import 'package:quit_gambling/feature/onboard/widget/lottie_feature_section.dart';
import 'package:quit_gambling/feature/onboard/widget/paywall_introducing_bottom_bar.dart';
import 'package:quit_gambling/product/constant/theme_constants.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class PaywallIntroducingView extends StatefulWidget {
  const PaywallIntroducingView({super.key});
  @override
  State<PaywallIntroducingView> createState() => _PaywallIntroducingViewState();
}

class _PaywallIntroducingViewState extends State<PaywallIntroducingView>
    with PaywallIntroducingViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: const PaywallIntroducingBottomBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: ThemeConstants().getLottieBackgroundLinearGradient,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              context.sized.emptySizedHeightBoxLow3x,
              context.sized.emptySizedHeightBoxLow3x,
              context.sized.emptySizedHeightBoxLow3x,
              const Icon(
                CupertinoIcons.check_mark_circled_solid,
                size: 48,
                color: Colors.white,
              ),
              context.sized.emptySizedHeightBoxLow,
              Text(
                "$userName, we've made you\na custom plan",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
              context.sized.emptySizedHeightBoxLow3x,
              Center(
                child: GradientText(
                  "You will quit gambling by:",
                  colors: const [
                    Color(0xffdedcdf),
                    Color.fromARGB(255, 120, 115, 121),
                  ],
                  gradientDirection: GradientDirection.ltr,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
              ),
              context.sized.emptySizedHeightBoxLow,
              context.sized.emptySizedHeightBoxLow,
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: context.border.highBorderRadius,
                ),
                child: Text(
                  targetDate,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              context.sized.emptySizedHeightBoxLow3x,
              Image.asset('assets/images/laurel.png', height: 64),
              context.sized.emptySizedHeightBoxLow3x,
              const Text(
                "Become the best of\nyourself with QUITBET",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
              context.sized.emptySizedHeightBoxLow,
              const Text(
                "Stronger. Healthier. Happier.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              context.sized.emptySizedHeightBoxLow3x,
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 12,
                children: benefitItems
                    .map((item) => _BenefitChip(
                          icon: item['icon'] as IconData,
                          label: item['text'] as String,
                          color: item['color'] as Color,
                        ))
                    .toList(),
              ),
              context.sized.emptySizedHeightBoxLow3x,
              const LottieFeatureSection(
                isTestimonial: true,
                lottiePath: 'assets/lottie/yoga.json',
                title: 'Build real relationships',
                features: [
                  FeatureItem(
                    icon: Icons.psychology,
                    text: 'Enhance your emotional intelligence',
                    color: Colors.blue,
                  ),
                  FeatureItem(
                    icon: Icons.link,
                    text: 'Be more trustworthy and dependable',
                    color: Colors.purple,
                  ),
                  FeatureItem(
                    icon: Icons.favorite,
                    text: 'Experience real intimacy and connection',
                    color: Colors.red,
                  ),
                  FeatureItem(
                    icon: Icons.person,
                    text: 'Become the person they deserve',
                    color: Colors.green,
                  ),
                ],
                testimonial:
                    'All this time my social anxiety was just because I was secretly ashamed of my porn problem. I never want to feel that small again.',
              ),
// Relationships section
              const LottieFeatureSection(
                isTestimonial: true,
                lottiePath: 'assets/lottie/achievement.json',
                title: 'Build real relationships',
                features: [
                  FeatureItem(
                    icon: Icons.lightbulb,
                    text: 'Enhance your emotional intelligence',
                    color: Color(0xFF0A84FF),
                  ),
                  FeatureItem(
                    icon: Icons.link,
                    text: 'Be more trustworthy and dependable',
                    color: Color(0xFF8E45FC),
                  ),
                  FeatureItem(
                    icon: Icons.favorite,
                    text: 'Experience real intimacy and connection',
                    color: Color(0xFFFA3151),
                  ),
                  FeatureItem(
                    icon: Icons.show_chart,
                    text: 'Become the person they deserve',
                    color: Color.fromRGBO(47, 197, 90, 1),
                  ),
                ],
                testimonial:
                    'Porn was hindering my ability to love, and I see now there was a distance in my relationship. I\'m so glad I turned things around when I did.',
              ),
              context.sized.emptySizedHeightBoxLow3x,
              Container(
                margin: context.padding.horizontalMedium,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.3),
                  borderRadius: context.border.normalBorderRadius,
                  border: Border.all(color: Colors.grey, width: .5),
                ),
                child: Padding(
                  padding: context.padding.verticalNormal +
                      context.padding.horizontalLow,
                  child: Column(
                    children: [
                      // Hand Icon
                      const Icon(
                        Icons.back_hand_rounded,
                        color: Colors.white,
                        size: 48,
                      ),
                      const SizedBox(height: 16),

                      // Simple daily habits title
                      const Text(
                        'Simple, daily habits',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),

                      // Description text
                      const Text(
                        'QUITBET teaches 100% science-based habits that make lasting, life-long freedom from gambling possible.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),

                      // Quit date section
                      const Text(
                        'You should quit gambling by:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),

                      // Date container
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xff1c1c1e),
                          borderRadius: context.border.highBorderRadius,
                        ),
                        child: Text(
                          targetDate,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // How to reach your goal section
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'How to reach your goal:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Goal steps
                      const _GoalStep(
                        icon: '🚫',
                        text: "Use QUITBET's content blocking filter",
                      ),
                      const SizedBox(height: 16),
                      const _GoalStep(
                        icon: '🔴',
                        text: 'Press the Panic Button when feeling tempted',
                      ),
                      const SizedBox(height: 16),
                      const _GoalStep(
                        icon: '🤚',
                        text: 'Pledge daily to not relapse',
                      ),
                      const SizedBox(height: 16),
                      const _GoalStep(
                        icon: '📈',
                        text: 'Track progress towards betterment',
                      ),
                    ],
                  ),
                ),
              ),
              context.sized.emptySizedHeightBoxLow3x,
              const LottieFeatureSection(
                isTestimonial: false,
                lottiePath: 'assets/lottie/hero.json',
                title: 'Build real relationships',
                features: [
                  FeatureItem(
                    icon: Icons.psychology,
                    text: 'Enhance your emotional intelligence',
                    color: Colors.blue,
                  ),
                  FeatureItem(
                    icon: Icons.link,
                    text: 'Be more trustworthy and dependable',
                    color: Colors.purple,
                  ),
                  FeatureItem(
                    icon: Icons.favorite,
                    text: 'Experience real intimacy and connection',
                    color: Colors.red,
                  ),
                  FeatureItem(
                    icon: Icons.person,
                    text: 'Become the person they deserve',
                    color: Colors.green,
                  ),
                ],
                testimonial:
                    'All this time my social anxiety was just because I was secretly ashamed of my porn problem. I never want to feel that small again.',
              ),
              context.sized.emptySizedHeightBoxLow3x,
              DiscountCard(
                discountAmount: '80',
                onClaimPressed: () {},
              ),
              context.sized.emptySizedHeightBoxLow3x,
            ],
          ),
        ),
      ),
    );
  }
}

class _BenefitChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _BenefitChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(.65),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class _GoalStep extends StatelessWidget {
  final String icon;
  final String text;

  const _GoalStep({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: Text(
            icon,
            style: const TextStyle(fontSize: 24),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
