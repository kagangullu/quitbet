import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kartal/kartal.dart';

enum PledgeState {
  initial,
  success,
}

class PledgeBottomSheet extends StatefulWidget {
  const PledgeBottomSheet({super.key});

  @override
  State<PledgeBottomSheet> createState() => _PledgeBottomSheetState();
}

class _PledgeBottomSheetState extends State<PledgeBottomSheet> {
  PledgeState _currentState = PledgeState.initial;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Color(0xff1a1a2e),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 24,
            ),
          ),
          const Text(
            'Pledge',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 24), // For balance
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_currentState) {
      case PledgeState.initial:
        return _buildInitialState();
      case PledgeState.success:
        return _buildSuccessState();
    }
  }

  Widget _buildInitialState() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Icon(
            Icons.back_hand,
            size: 40,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Pledge Sobriety Today',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            "Make a commitment to yourself not to relapse for today. You'll receive a notification in 24 hours to check in and see how you did.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(height: 32),
        _buildInfoItem(
          Icons.check_circle_outline,
          'Achievable Goal',
          'When pledging, you agree to not relapse for the day only.',
        ),
        _buildInfoItem(
          Icons.spa_outlined,
          'Take it Easy',
          "Just live the day as normal and after pledging, don't change your mind",
        ),
        _buildInfoItem(
          Icons.done_rounded,
          'Success is Inevitable',
          'Stay strong, the first few days/weeks will be tough but after that',
        ),
        const Spacer(),
        Padding(
          padding: context.padding.horizontalNormal +
              context.padding.onlyBottomMedium,
          child: SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text('Pledge to not relapse today?'),
                    content: const Text(
                      "You'll receive a notification in 24 hours to check in and see how you did.",
                    ),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: CupertinoColors.activeBlue,
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        child: const Text(
                          'Pledge',
                          style: TextStyle(
                            color: CupertinoColors.activeBlue,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            _currentState = PledgeState.success;
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
              color: Colors.white,
              borderRadius: context.border.highBorderRadius,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: const Text(
                "Pledge Now",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Icon(
          size: 150,
          CupertinoIcons.check_mark_circled,
          color: Colors.white.withOpacity(0.9),
        ),
        context.sized.emptySizedHeightBoxLow,
        const Text(
          'Pledge Successful',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "You'll receive a notification in 24 hours to check in and see how you did. Remember why you started, good luck!",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        const Spacer(),
        Padding(
          padding: context.padding.horizontalNormal +
              context.padding.onlyBottomMedium,
          child: SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.white,
              borderRadius: context.border.highBorderRadius,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: const Text(
                "Finish",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        context.sized.emptySizedHeightBoxLow3x,
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white.withOpacity(0.9),
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
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
