// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:quit_gambling/feature/onboard/view/calculating_view.dart';
import 'package:quit_gambling/feature/onboard/view/check_symptoms_view.dart';
import 'package:quit_gambling/feature/onboard/view_model/onboard_quiz_view_model.dart';
import 'package:quit_gambling/product/constant/theme_constants.dart';

class OnboardQuizView extends StatefulWidget {
  const OnboardQuizView({super.key});

  @override
  State<OnboardQuizView> createState() => _OnboardQuizViewState();
}

class _OnboardQuizViewState extends State<OnboardQuizView>
    with OnboardQuizViewModel {
  Widget _buildFormPage(BuildContext context) {
    return Padding(
      padding: context.padding.horizontalNormal * 1.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          context.sized.emptySizedHeightBoxLow3x,
          context.sized.emptySizedHeightBoxLow,
          const Center(
            child: Text(
              'Finally',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          context.sized.emptySizedHeightBoxLow3x,
          RichText(
            text: const TextSpan(
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(text: 'A little more '),
                TextSpan(
                  text: 'about you',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: nameController,
            style: const TextStyle(color: Colors.white),
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: 'Name',
              hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              filled: true,
              fillColor: const Color(0xff141426),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: ageController,
            style: const TextStyle(color: Colors.white),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Age',
              hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              filled: true,
              fillColor: const Color(0xff141426),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
            ),
          ),
          context.sized.emptySizedHeightBoxLow3x,
          GestureDetector(
            onTap: isFormComplete
                ? () async {
                    if (context.mounted) {
                      if (isSkipped) {
                        FocusScope.of(context).unfocus();

                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const CheckSymptomsView(),
                          ),
                        );
                      } else {
                        FocusScope.of(context).unfocus();
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const CalculatingView(),
                          ),
                        );
                      }
                    }
                  }
                : null,
            child: Container(
              height: context.sized.height * 0.07,
              decoration: BoxDecoration(
                color: isFormComplete ? Colors.white : const Color(0xff51515F),
                borderRadius: context.border.highBorderRadius,
              ),
              child: Center(
                child: Text(
                  "Complete Quiz",
                  style: TextStyle(
                    color:
                        isFormComplete ? Colors.black : const Color(0xff383946),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final progress = (currentQuestionIndex) / (questions.length + 1);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: ThemeConstants().getBackgroundLinearGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: context.padding.horizontalNormal * 1.5,
                child: Column(
                  children: [
                    context.sized.emptySizedHeightBoxLow,
                    context.sized.emptySizedHeightBoxLow,
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (!isAnimating && currentQuestionIndex > 0) {
                              pageController.previousPage(
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.easeInOut,
                              );
                              setState(() {
                                currentQuestionIndex--;
                              });
                            } else if (!isAnimating &&
                                currentQuestionIndex == 0) {
                              Navigator.pop(context);
                            }
                          },
                          child: const Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                          ),
                        ),
                        context.sized.emptySizedWidthBoxLow3x,
                        Expanded(
                          child: TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 250),
                            tween: Tween<double>(
                              begin: progress - 0.01,
                              end: progress,
                            ),
                            builder: (context, value, child) {
                              return LinearProgressIndicator(
                                value: value,
                                minHeight: 7,
                                backgroundColor: const Color(0xFF1E1E1E),
                                color: const Color(0xff55ba36),
                                borderRadius: context.border.highBorderRadius,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: questions.length + 1,
                  itemBuilder: (context, index) {
                    if (index == questions.length) {
                      return _buildFormPage(context);
                    }

                    final question = questions[index];
                    final selectedAnswerIndex = selectedAnswers[index];

                    return Padding(
                      padding: context.padding.horizontalNormal * 1.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          context.sized.emptySizedHeightBoxLow3x,
                          context.sized.emptySizedHeightBoxLow,
                          Center(
                            child: Text(
                              'Question #${question.id}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          context.sized.emptySizedHeightBoxLow3x,
                          Padding(
                            padding: context.padding.onlyRightNormal,
                            child: Text(
                              question.text,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          for (var i = 0; i < question.answers.length; i++)
                            Padding(
                              padding: context.padding.onlyTopNormal,
                              child: GestureDetector(
                                onTapDown: (_) {
                                  setState(() {
                                    isPressed[i] = true;
                                  });
                                },
                                onTapUp: (_) {
                                  setState(() {
                                    isPressed[i] = false;
                                  });
                                  handleAnswerSelection(i);
                                },
                                onTapCancel: () {
                                  setState(() {
                                    isPressed[i] = false;
                                  });
                                },
                                child: Container(
                                  width: context.sized.width,
                                  height: context.sized.height * 0.07,
                                  decoration: BoxDecoration(
                                    color: selectedAnswerIndex == i
                                        ? const Color(0xff131240)
                                        : isPressed[i] == true
                                            ? const Color(0xff131240)
                                                .withOpacity(.7)
                                            : const Color(0xff131240),
                                    borderRadius:
                                        context.border.lowBorderRadius * 2,
                                  ),
                                  child: Padding(
                                    padding: context.padding.horizontalNormal,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        TweenAnimationBuilder<Color?>(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          tween: ColorTween(
                                            begin: isPressed[i] == true
                                                ? const Color(0xff02C6FB)
                                                    .withOpacity(.7)
                                                : const Color(0xff02C6FB),
                                            end: selectedAnswerIndex == i
                                                ? isPressed[i] == true
                                                    ? const Color(0xff55ba36)
                                                        .withOpacity(.7)
                                                    : const Color(0xff55ba36)
                                                : isPressed[i] == true
                                                    ? const Color(0xff02C6FB)
                                                        .withOpacity(.7)
                                                    : const Color(0xff02C6FB),
                                          ),
                                          builder: (context, color, child) {
                                            return Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: color,
                                              ),
                                              child: Center(
                                                child: AnimatedSwitcher(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  child: selectedAnswerIndex ==
                                                          i
                                                      ? const Icon(
                                                          Icons.check,
                                                          color: Colors.black,
                                                          size: 20,
                                                        )
                                                      : Text(
                                                          '${i + 1}',
                                                          style: TextStyle(
                                                            color: isPressed[
                                                                        i] ==
                                                                    true
                                                                ? const Color(
                                                                        0xff131240)
                                                                    .withOpacity(
                                                                        .7)
                                                                : const Color(
                                                                    0xff131240),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        context.sized.emptySizedWidthBoxLow3x,
                                        Text(
                                          question.answers[i],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          const Spacer(),
                          Center(
                            child: CupertinoButton(
                              onPressed: () {
                                showCupertinoDialog(
                                  context: context,
                                  builder: (context) => CustomCupertinoDialog(
                                    onCancel: () {
                                      Navigator.of(context).pop();
                                    },
                                    onSkip: () {
                                      Navigator.of(context).pop();
                                      isSkipped = true;
                                      if (!isAnimating) {
                                        pageController.jumpTo(
                                          pageController
                                              .position.maxScrollExtent,
                                        );
                                        setState(() {
                                          currentQuestionIndex =
                                              questions.length;
                                        });
                                      }
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                'Skip test',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCupertinoDialog extends StatelessWidget {
  final Function() onCancel;
  final Function() onSkip;

  const CustomCupertinoDialog({
    super.key,
    required this.onCancel,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text(
        'Are you sure?',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text(
          'We use this to make your custom gambling-quitting plan more accurate.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
          ),
        ),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: onCancel,
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: CupertinoColors.systemBlue,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        CupertinoDialogAction(
          onPressed: onSkip,
          child: const Text(
            'Skip',
            style: TextStyle(
              color: CupertinoColors.systemRed,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
