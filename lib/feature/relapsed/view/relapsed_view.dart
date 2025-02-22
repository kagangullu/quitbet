import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:quit_gambling/product/services/abstinence_tracker_service.dart';

class RelapsedView extends StatefulWidget {
  const RelapsedView({super.key});

  @override
  State<RelapsedView> createState() => _RelapsedScreenState();
}

class _RelapsedScreenState extends State<RelapsedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff060724),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        title: const Text(
          "Relapsed",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Color(0xfffe4538),
          ),
        ),
      ),
      backgroundColor: const Color(0xff060724),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const SizedBox(height: 8.0),
                // buildHeader(),
                const SizedBox(height: 40.0),
                buildMainTitle('You let yourself down, again.'),
                const SizedBox(height: 16.0),
                buildDescription(
                  'Relapsing can be tough and make you feel awful, but it\'s crucial not to be too hard on yourself. Doing so can create a vicious cycle, as explained below.',
                ),
                const SizedBox(height: 40.0),
                buildSectionTitle('Relapsing Cycle of Death'),
                const SizedBox(height: 24.0),
                buildCycleStep(
                  isFirst: true,
                  icon: Icons.casino,
                  title: 'Gambling',
                  description:
                      'In the moment during betting, you feel incredible excitement and anticipation.',
                  isLast: false,
                ),

                buildCycleStep(
                  isFirst: false,
                  icon: Icons.visibility,
                  title: 'Post-Bet Clarity',
                  description:
                      'Shortly after losing, the excitement fades, leaving you with regret, sadness, and depression.',
                  isLast: false,
                ),

                buildCycleStep(
                  isFirst: false,
                  icon: Icons.sync,
                  title: 'Compensation Cycle',
                  description:
                      'You gamble again to win back losses or alleviate the low feelings, perpetuating the cycle. If you don\'t stop, it becomes increasingly difficult to break free.',
                  isLast: true,
                ),
                const SizedBox(height: 24.0),
                buildJournalButton(),
                const SizedBox(height: 40.0),
                // Second screen content starts here
                buildMainTitle(
                    'Your strength is proven in your ability to overcome addiction.'),
                const SizedBox(height: 16.0),
                const Text(
                  'You got this, the QUITBET team believes in you 💙',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff1283f1),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40.0),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(),
    );
  }

  // Widget buildHeader() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       IconButton(
  //         icon: const Icon(Icons.arrow_back),
  //         onPressed: () {},
  //         color: Colors.white,
  //       ),
  //       const Text(
  //         'Relapsed',
  //         style: TextStyle(
  //           fontSize: 20.0,
  //           fontWeight: FontWeight.w600,
  //           color: Color(0xfffe4538),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget buildMainTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 36.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget buildDescription(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16.0,
        color: Colors.grey,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget buildSectionTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildCycleStep({
    required IconData icon,
    required String title,
    required String description,
    required bool isLast,
    required bool isFirst,
  }) {
    return Padding(
      padding: context.padding.horizontalNormal,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xff12133c),
          borderRadius: isLast
              ? BorderRadius.only(
                  bottomLeft: context.border.normalRadius,
                  bottomRight: context.border.normalRadius,
                )
              : isFirst
                  ? BorderRadius.only(
                      topLeft: context.border.normalRadius,
                      topRight: context.border.normalRadius)
                  : BorderRadius.zero,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.white70,
              size: 20.0,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey,
                      height: 1.4,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildJournalButton() {
    return Padding(
      padding: context.padding.horizontalNormal,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xff12133c),
          borderRadius: context.border.normalBorderRadius,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.edit_note,
              color: Colors.white,
              size: 22.0,
            ),
            SizedBox(width: 12.0),
            Text(
              'Journal Feelings',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Spacer(),
            Icon(
              Icons.chevron_right,
              color: Colors.white70,
            ),
            SizedBox(width: 8.0),
          ],
        ),
      ),
    );
  }

  final AbstinenceTrackerService trackerService = AbstinenceTrackerService();

  Future<void> resetTracking() async {
    await trackerService.resetTracking();
    if (mounted) setState(() {});
  }

  Widget buildBottomNavBar() {
    return Container(
      padding: const EdgeInsets.only(bottom: 32.0, top: 12) +
          context.padding.horizontalNormal,
      decoration: const BoxDecoration(
        color: Color(0xff060724),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xfffe4538),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
            resetTracking();
            setState(() {});
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.refresh_bold,
                color: Colors.white,
                size: 20.0,
              ),
              SizedBox(width: 10.0),
              Text(
                'Reset Counter',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
