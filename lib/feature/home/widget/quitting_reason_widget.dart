import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:quit_gambling/product/widget/my_cupertino_button.dart';

class QuitReasonCard extends StatefulWidget {
  const QuitReasonCard({super.key});

  @override
  State<QuitReasonCard> createState() => _QuitReasonCardState();
}

class _QuitReasonCardState extends State<QuitReasonCard> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: context.padding.verticalLow,
      decoration: BoxDecoration(
        color: const Color(0xff11133c),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF373737), width: 0.7),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.help_outline,
                  color: Colors.grey[400],
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  "I'm quitting because:",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Icon(
                  CupertinoIcons.pencil,
                  color: Colors.grey[400],
                  size: 20,
                ),
              ],
            ),
            GestureDetector(
              onTapDown: (TapDownDetails details) async {
                setState(() {
                  isPressed = true;
                });
                final position = Rect.fromCenter(
                  center: details.globalPosition,
                  width: 0,
                  height: -100,
                );

                await showPullDownMenu(
                  context: context,
                  position: position,
                  items: [
                    PullDownMenuItem(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          builder: (context) => const QuitBottomSheet(),
                        );
                      },
                      title: 'Edit reason',
                      icon: CupertinoIcons.pencil,
                    ),
                  ],
                );
                setState(() {
                  isPressed = false;
                });
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "Click here to add a reason why you're quitting",
                  style: TextStyle(
                    color: isPressed ? Colors.white60 : Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuitBottomSheet extends StatefulWidget {
  const QuitBottomSheet({super.key});

  @override
  State<QuitBottomSheet> createState() => _QuitBottomSheetState();
}

class _QuitBottomSheetState extends State<QuitBottomSheet> {
  TextEditingController controller = TextEditingController();
  bool isTextNotEmpty = false; // Yeni state değişkeni

  @override
  void initState() {
    super.initState();
    // Controller'a listener ekleyerek text değişimlerini dinliyoruz
    controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    controller.removeListener(_onTextChanged); // Listener'ı kaldırıyoruz
    controller.dispose();
    super.dispose();
  }

  // Text değiştiğinde çağrılacak method
  void _onTextChanged() {
    setState(() {
      isTextNotEmpty = controller.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.sized.height * 0.9,
      decoration: const BoxDecoration(
        color: Color(0xff1c1c1e),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  child: const Icon(
                    CupertinoIcons.xmark,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  'Quitting Reason',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CupertinoButton(
                  child: const Icon(
                    CupertinoIcons.question_circle,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            context.sized.emptySizedHeightBoxLow3x,
            Padding(
              padding: context.padding.horizontalNormal,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff272729),
                  borderRadius: context.border.normalBorderRadius,
                ),
                child: TextField(
                  controller: controller,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 6,
                  decoration: const InputDecoration(
                    hintText:
                        'Why are you committed to the No-Nut journey? How is it affecting you, how do you feel when you relapse? (required)',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xff656567),
                      fontSize: 15.5,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
            ),
            context.sized.emptySizedHeightBoxLow3x,
            Padding(
              padding: context.padding.horizontalMedium,
              child: SizedBox(
                width: double.infinity,
                child: MyCupertinoButton(
                  hintText: "Save",
                  isActive: isTextNotEmpty,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
