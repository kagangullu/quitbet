import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kartal/kartal.dart';
import 'package:quit_gambling/product/constant/theme_constants.dart';
import 'package:quit_gambling/product/widget/my_cupertino_button.dart';
import 'package:lottie/lottie.dart';

class MoodPanel extends StatefulWidget {
  final Function(String mood, bool isTempted) onSave;

  const MoodPanel({
    super.key,
    required this.onSave,
  });

  @override
  State<MoodPanel> createState() => _MoodPanelState();
}

class _MoodPanelState extends State<MoodPanel> {
  String? selectedMood;
  bool isTempted = false;

  final List<Map<String, dynamic>> moods = [
    {'emoji': '😄', 'value': 'happy'},
    {'emoji': '😴', 'value': 'tired'},
    {'emoji': '😐', 'value': 'neutral'},
    {'emoji': '😟', 'value': 'worried'},
    {'emoji': '😢', 'value': 'sad'},
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: const BoxDecoration(
            color: Color(0xFF1E1E1E),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Stack(
            children: [
              // Lottie animation as background
              Positioned.fill(
                child: Lottie.asset(
                  'assets/lottie/bg.json',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.9),
                ),
              ),
              // Gradient overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient:
                        ThemeConstants().getLottieBackgroundLinearGradient,
                  ),
                ),
              ),
              // Original content
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  Center(child: _buildHeader()),
                  _buildMoodSelector(),
                  _buildTemptedToggle(),
                  const Spacer(),
                  Padding(
                    padding: context.padding.horizontalNormal,
                    child: MyCupertinoButton(
                      isActive: selectedMood != null ? true : false,
                      hintText: "Save",
                      onTap: () {
                        if (selectedMood != null) {
                          widget.onSave(selectedMood!, isTempted);
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                  _buildDismissButton(),
                  context.sized.emptySizedHeightBoxLow3x,
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        'How do you feel right now?',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMoodSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: moods.map((mood) {
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => selectedMood = mood['value']),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: selectedMood == mood['value']
                      ? const Color(0xff363638)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  mood['emoji'],
                  style: const TextStyle(fontSize: 32),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTemptedToggle() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Are you tempted to relapse right now?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          CupertinoSwitch(
            value: isTempted,
            onChanged: (value) => setState(() => isTempted = value),
            activeColor: const Color(0xff0a84ff),
          ),
        ],
      ),
    );
  }

  Widget _buildDismissButton() {
    return CupertinoButton(
      onPressed: () => Navigator.pop(context),
      child: const Text(
        'Dismiss',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
