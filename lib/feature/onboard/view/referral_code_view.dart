import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:quit_gambling/feature/onboard/view/give_rating_view.dart';
import 'package:quit_gambling/product/constant/theme_constants.dart';

class ReferralCodeView extends StatefulWidget {
  const ReferralCodeView({super.key});

  @override
  State<ReferralCodeView> createState() => _ReferralCodeViewState();
}

class _ReferralCodeViewState extends State<ReferralCodeView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: ThemeConstants().getBackgroundLinearGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: context.padding.horizontalNormal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
                context.sized.emptySizedHeightBoxLow3x,
                const Text(
                  "Do you have a\nreferral code?",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                context.sized.emptySizedHeightBoxLow,
                const Text(
                  'You can skip this step.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                TextField(
                  controller: _controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Referral Code',
                    hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    filled: true,
                    fillColor: const Color(0xff11111f),
                    border: OutlineInputBorder(
                      borderRadius: context.border.normalBorderRadius,
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  margin: context.padding.horizontalLow / 2 +
                      context.padding.onlyBottomLow,
                  width: double.infinity,
                  child: CupertinoButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const GiveRatingView(),
                        ),
                      );
                    },
                    color: Colors.white,
                    borderRadius: context.border.highBorderRadius,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
