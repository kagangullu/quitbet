import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:quit_gambling/log.dart';
import 'package:superwallkit_flutter/superwallkit_flutter.dart';

class PaywallIntroducingBottomBar extends StatelessWidget {
  const PaywallIntroducingBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          Padding(
            padding: context.padding.horizontalLow,
            child: Container(
              color: Colors.transparent,
              margin: context.padding.horizontalLow / 2 +
                  context.padding.onlyBottomLow,
              width: double.infinity,
              child: CupertinoButton(
                onPressed: () async {
                  HapticFeedback.lightImpact();
                  try {
                    await Superwall.shared.registerEvent('campaign_trigger');
                  } catch (e) {
                    Log().error('Superwall event error: $e');
                  }
                },
                color: Colors.white,
                borderRadius: context.border.highBorderRadius,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                child: const Text(
                  "QUIT GAMBLING NOW",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          // Padding(
          context.sized.emptySizedHeightBoxLow,
          context.sized.emptySizedHeightBoxLow,
          const Text(
            "Purchase appears Discretely",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 4),
            child: Center(
              child: Text(
                "Cancel Anytime ✅ Money back guarantee 🛡️",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
