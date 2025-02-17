import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:quit_gambling/feature/onboard/view/introducing_onboard_view.dart';

class CheckSymptomsView extends StatefulWidget {
  const CheckSymptomsView({
    super.key,
  });

  @override
  State<CheckSymptomsView> createState() => _CheckSymptomsViewState();
}

class _CheckSymptomsViewState extends State<CheckSymptomsView> {
  final Map<String, bool> pressedStates = {};

  Map<String, bool> symptoms = {
    // Mental symptoms
    'Feeling unmotivated': false,
    'Lack of ambition to pursue goals': false,
    'Difficulty concentrating': false,
    'Poor memory or \'brain fog\'': false,
    'General anxiety': false,
    'Tiredness and lethargy': false,

    // Physical symptoms
    'Frequent headaches': false,
    'Poor sleep quality': false,
    'Weight gain': false,
    'Muscle tension': false,
    'Digestive issues': false,

    // Sexual symptoms
    'Low libido or sex drive': false,
    'Weak erections without porn': false,
    'Delayed ejaculation': false,
    'Loss of morning wood': false,

    // Social symptoms
    'Low self-confidence': false,
    'Feeling unattractive or unworthy': false,
    'Social anxiety': false,
    'Difficulty maintaining eye contact': false,
    'Avoiding social situations': false,
  };

  final Map<String, List<String>> symptomCategories = {
    'Mental': [
      'Feeling unmotivated',
      'Lack of ambition to pursue goals',
      'Difficulty concentrating',
      'Poor memory or \'brain fog\'',
      'General anxiety',
      'Tiredness and lethargy',
    ],
    'Physical': [
      'Frequent headaches',
      'Poor sleep quality',
      'Weight gain',
      'Muscle tension',
      'Digestive issues',
    ],
    'Sexual': [
      'Low libido or sex drive',
      'Weak erections without porn',
      'Delayed ejaculation',
      'Loss of morning wood',
    ],
    'Social': [
      'Low self-confidence',
      'Feeling unattractive or unworthy',
      'Social anxiety',
      'Difficulty maintaining eye contact',
      'Avoiding social situations',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        bottomNavigationBar: Container(
          color: const Color(0xFF0A0B1E),
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 48,
            top: 32,
          ),
          child: CupertinoButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => const IntroducingOnboardView(),
                ),
              );
            },
            color: const Color(0xFFFF3F00),
            borderRadius: context.border.highBorderRadius,
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 32,
            ),
            child: const Text(
              "Reboot my brain",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        body: CupertinoPageScaffold(
          backgroundColor: const Color(0xFF0A0B1E),
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                CupertinoSliverNavigationBar(
                  backgroundColor: const Color(0xFF0A0B1E),
                  padding: EdgeInsetsDirectional.zero,
                  leading: Padding(
                    padding: context.padding.onlyLeftLow,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        CupertinoIcons.back,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                  largeTitle: const Text(
                    'Symptoms',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  border: null,
                ),
              ];
            },
            body: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF3F00),
                                borderRadius: context.border.normalBorderRadius,
                              ),
                              child: const Text(
                                'Excessive porn use can have negative impacts psychologically.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            context.sized.emptySizedHeightBoxLow3x,
                            context.sized.emptySizedHeightBoxLow3x,
                            const Text(
                              'Select any symptoms below:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),

                    // Categories and symptoms
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final category =
                                symptomCategories.entries.elementAt(index);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  category.key,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                _buildSymptomSection(category.value),
                                const SizedBox(height: 24),
                              ],
                            );
                          },
                          childCount: symptomCategories.length,
                        ),
                      ),
                    ),

                    // Bottom padding for the last item
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 100),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSymptomSection(List<String> sectionSymptoms) {
    return Column(
      children: sectionSymptoms.map((symptom) {
        final bool isSelected = symptoms[symptom] ?? false;
        final bool isPressed = pressedStates[symptom] ?? false;

        return GestureDetector(
          onTapDown: (_) => setState(() => pressedStates[symptom] = true),
          onTapUp: (_) => setState(() => pressedStates[symptom] = false),
          onTapCancel: () => setState(() => pressedStates[symptom] = false),
          onTap: () {
            HapticFeedback.lightImpact();
            setState(() {
              symptoms[symptom] = !isSelected;
            });
          },
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 50),
            opacity: isPressed ? 0.5 : 1.0,
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xff642214)
                    : const Color(0xff121343),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? const Color(0xfff25328)
                            : Colors.transparent,
                        border: Border.all(
                          color: isSelected
                              ? Colors.transparent
                              : Colors.white.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        symptom,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
