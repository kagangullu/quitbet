import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class JoinGroupDialog extends StatelessWidget {
  const JoinGroupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text(
        'Join Group Chat',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: const Text(
        "We highly recommend you to join our community chat to help beat your addiction. You're not alone.",
        style: TextStyle(
          fontSize: 13,
        ),
        textAlign: TextAlign.center,
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: CupertinoColors.systemBlue,
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () async {
            final Uri url = Uri.parse('https://t.me/+f-L9wmRlWNdiMmJk');
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            }
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
          child: const Text(
            'Join Chat',
            style: TextStyle(
              color: Color(0xfffa483d),
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
