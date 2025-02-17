import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';

class LottieFeatureSection extends StatelessWidget {
  final String lottiePath;
  final String title;
  final List<FeatureItem> features;
  final String testimonial;
  final double height;
  final bool isTestimonial;

  const LottieFeatureSection({
    super.key,
    required this.lottiePath,
    required this.title,
    required this.features,
    required this.testimonial,
    this.height = 200,
    required this.isTestimonial,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(
          lottiePath,
          height: height,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        context.sized.emptySizedHeightBoxLow3x,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: features
                .map((feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _BenefitRow(
                        icon: feature.icon,
                        text: feature.text,
                        color: feature.color,
                      ),
                    ))
                .toList(),
          ),
        ),
        context.sized.emptySizedHeightBoxLow3x,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          margin: const EdgeInsets.symmetric(horizontal: 110),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            border: Border.all(
              color: Colors.grey,
              width: 0.4,
            ),
            borderRadius: context.border.highBorderRadius,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.amber, size: 24),
              Icon(Icons.star, color: Colors.amber, size: 24),
              Icon(Icons.star, color: Colors.amber, size: 24),
              Icon(Icons.star, color: Colors.amber, size: 24),
              Icon(Icons.star, color: Colors.amber, size: 24),
            ],
          ),
        ),
        isTestimonial
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: Text(
                  testimonial,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : const SizedBox.shrink(),
        isTestimonial
            ? const Text(
                "Anonymous",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              )
            : const SizedBox.shrink(),
        context.sized.emptySizedHeightBoxLow3x,
      ],
    );
  }
}

class FeatureItem {
  final IconData icon;
  final String text;
  final Color color;

  const FeatureItem({
    required this.icon,
    required this.text,
    required this.color,
  });
}

class _BenefitRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _BenefitRow({
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: context.border.highBorderRadius,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 14,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
