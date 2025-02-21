part of '../view/home_view.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({
    super.key,
    required this.title,
    required this.value,
    required this.iconOrEmoji,
    required this.iconColor,
    required this.onTap,
    required this.textColor,
    required this.isEmoji,
  });

  final String title;
  final String value;
  final dynamic iconOrEmoji;
  final Color iconColor;
  final VoidCallback onTap;
  final Color textColor;
  final bool isEmoji;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 12,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xff11133c),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF373737), width: 0.7),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: title.contains('track') ? 10 : 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -15,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Color(0xff11133c),
                  shape: BoxShape.circle,
                ),
                child: isEmoji
                    ? Text(
                        iconOrEmoji,
                        style: const TextStyle(fontSize: 30),
                      )
                    : Icon(
                        iconOrEmoji,
                        color: iconColor,
                        size: 36,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
