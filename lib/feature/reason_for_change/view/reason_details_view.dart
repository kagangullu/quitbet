import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ReasonDetailsView extends StatelessWidget {
  final String? reasonText;

  const ReasonDetailsView({
    super.key,
    this.reasonText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(44),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: const SafeArea(
            child: NavigationToolbar(
              leading: CupertinoNavigationBarBackButton(
                color: Colors.white,
              ),
              middle: Text(
                'Reason Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              trailing: SizedBox(width: 44),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: context.padding.horizontalNormal,
            child: Text(
              reasonText!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
