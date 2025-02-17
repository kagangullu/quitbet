import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:quit_gambling/feature/onboard/view/choose_your_goals.dart';
import 'package:quit_gambling/product/constant/theme_constants.dart';

class RewiringBenefits1 extends StatefulWidget {
  const RewiringBenefits1({super.key});

  @override
  State<RewiringBenefits1> createState() => _RewiringBenefits1State();
}

class _RewiringBenefits1State extends State<RewiringBenefits1> {
  final List<TestimonialData> testimonials = [
    TestimonialData(
      name: 'Jack',
      shortText:
          "I feel like a different person. I'm much more talkative and aware.",
      longText:
          "After only 11 days, I feel like a different person. I'm much more talkative and aware in social settings. At work, I'm on top of everything instead of forgetting things and asking people to repeat themselves.",
    ),
    TestimonialData(
      name: 'Michael',
      shortText: "I want to go out, I want to workout, I want to live!",
      longText:
          "Everyday things like talking to a friend, or seeing a girl smile, have started to take on new meaning. I want to go out, I want to workout, I want to live! I haven't felt these emotions in 4 years.",
    ),
    TestimonialData(
      name: 'Connor',
      shortText:
          "Quitting has allowed me to change my mindset on the little things in life.",
      longText:
          "I was coming to grips with the fact that life is dark, boring, depressing and then I",
    ),
  ];
  bool showGraph = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: ThemeConstants().getBackgroundLinearGradient,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, top: 8.0),
                    child: Text(
                      'Rewiring Benefits',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              context.sized.emptySizedHeightBoxLow,
              Expanded(
                child: Stack(
                  children: [
                    if (!showGraph)
                      ListView(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        padding: const EdgeInsets.only(bottom: 24),
                        children: [
                          ...testimonials.map((testimonial) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: TestimonialCard(
                                  name: testimonial.name,
                                  shortText: testimonial.shortText,
                                  longText: testimonial.longText,
                                ),
                              )),
                        ],
                      ),
                    if (showGraph)
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: context.padding.horizontalLow,
                              child: Image.asset(
                                'assets/images/graph.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            context.sized.emptySizedHeightBoxLow3x,
                            Padding(
                              padding: context.padding.horizontalNormal,
                              child: const Text(
                                'BetOff helps you quit gambling 76% faster than willpower alone. 📈',
                                textAlign: TextAlign.center,
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
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 4, left: 16, right: 16),
                width: double.infinity,
                child: CupertinoButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    if (!showGraph) {
                      setState(() {
                        showGraph = true;
                      });
                    } else {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const ChooseYourGoals(),
                        ),
                      );
                    }
                  },
                  color: const Color(0xff0186ff),
                  borderRadius: context.border.highBorderRadius,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TestimonialData {
  final String name;
  final String shortText;
  final String longText;

  TestimonialData({
    required this.name,
    required this.shortText,
    required this.longText,
  });
}

class TestimonialCard extends StatelessWidget {
  final String name;
  final String shortText;
  final String longText;

  const TestimonialCard({
    super.key,
    required this.name,
    required this.shortText,
    required this.longText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Material(
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'avatar_$name',
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[800],
                child: Text(
                  name[0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xff011c41),
                      borderRadius: BorderRadius.only(
                        topRight: context.border.normalRadius,
                        bottomLeft: context.border.normalRadius,
                        bottomRight: context.border.normalRadius,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shortText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          longText,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                            height: 1.4, // Satır aralığını artıralım
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
