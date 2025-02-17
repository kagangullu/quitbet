import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quit_gambling/feature/onboard/view/onboard_quiz_view.dart';
import 'package:quit_gambling/product/model/onboard_question_model.dart';
import 'package:quit_gambling/product/services/mixpanel_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin OnboardQuizViewModel on State<OnboardQuizView> {
  late final PageController pageController;
  int currentQuestionIndex = 0;
  bool isAnimating = false;
  final Map<int, bool> isPressed = {};
  bool isFormComplete = false;
  bool isSkipped = false;

  static const String keyName = 'user_name';
  static const String keyAge = 'user_age';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  Map<int, int?> selectedAnswers = {};

  final questions = [
    Question(
      id: 1,
      text: 'How old were you when you first gambled?',
      answers: [
        'Under 18',
        '18 to 25',
        '26 to 35',
        '36 or older',
      ],
    ),
    Question(
      id: 2,
      text: 'How often do you gamble?',
      answers: [
        'Daily',
        '2-3 times a week',
        'Weekly',
        'Monthly',
      ],
    ),
    Question(
      id: 3,
      text: 'How much do you spend on gambling monthly?',
      answers: [
        'Less than \$100',
        '\$100 to \$500',
        '\$500 to \$2000',
        'More than \$2000',
      ],
    ),
    Question(
      id: 4,
      text: 'What type of gambling do you engage in most?',
      answers: [
        'Sports betting',
        'Casino games',
        'Poker',
        'Slot machines',
      ],
    ),
    Question(
      id: 5,
      text: 'Have you ever borrowed money to gamble?',
      answers: [
        'Yes',
        'No',
      ],
    ),
    Question(
      id: 6,
      text: "What's your main reason for gambling?",
      answers: [
        'Entertainment',
        'Making money',
        'Escape from stress',
        'Social activity',
      ],
    ),
    Question(
      id: 7,
      text: 'How long are your typical gambling sessions?',
      answers: [
        'Less than 1 hour',
        '1-3 hours',
        '3-6 hours',
        'More than 6 hours',
      ],
    ),
    Question(
      id: 8,
      text: 'How many times have you tried to quit gambling?',
      answers: [
        'Never',
        '1-2 times',
        '3-5 times',
        'More than 5 times',
      ],
    ),
    Question(
      id: 9,
      text: "Do you gamble more when you're feeling:",
      answers: [
        'Happy',
        'Stressed',
        'Bored',
        'Lonely',
      ],
    ),
    Question(
      id: 10,
      text: "How much of your income goes to gambling?",
      answers: [
        'Less than 10%',
        '10-30%',
        '30-50%',
        'More than 50%',
      ],
    ),
    Question(
      id: 11,
      text: "What's your primary motivation to quit?",
      answers: [
        'Financial reasons',
        'Family',
        'Mental health',
        'Career impact',
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    nameController.addListener(checkFormCompletion);
    ageController.addListener(checkFormCompletion);
    loadSavedData();
    _trackOnboardingStarted();
  }

  Future<void> _trackOnboardingStarted() async {
    await MixpanelManager.trackOnboardingStarted();
  }

  Future<void> loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString(keyName) ?? '';
      ageController.text = prefs.getString(keyAge) ?? '';
    });
  }

  // Add method to save data
  Future<void> saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyName, nameController.text);
    await prefs.setString(keyAge, ageController.text);
  }

  void checkFormCompletion() {
    setState(() {
      isFormComplete =
          nameController.text.isNotEmpty && ageController.text.isNotEmpty;
    });

    // Save data whenever form is updated
    if (isFormComplete) {
      saveUserData();
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  Future<void> handleAnswerSelection(int index) async {
    if (isAnimating) return;

    setState(() {
      selectedAnswers[currentQuestionIndex] = index;
      isAnimating = true;
    });

    // Track current step
    await MixpanelManager.trackOnboardingStep(
      stepNumber: currentQuestionIndex + 1,
    );

    HapticFeedback.lightImpact();

    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) {
        Future.delayed(const Duration(milliseconds: 250), () {
          if (mounted) {
            setState(() {
              isAnimating = false;
            });

            pageController.nextPage(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
            );

            setState(() {
              currentQuestionIndex++;
            });
          }
        });
      }
    });
  }
}
