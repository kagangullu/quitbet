import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class MyCupertinoButton extends StatefulWidget {
  const MyCupertinoButton({
    super.key,
    required this.hintText,
    required this.isActive,
    required this.onTap,
  });

  final String hintText;
  final bool isActive;
  final VoidCallback onTap;

  @override
  State<MyCupertinoButton> createState() => _MyCupertinoButtonState();
}

class _MyCupertinoButtonState extends State<MyCupertinoButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.isActive ? Colors.white : const Color(0xFF404040),
        borderRadius: context.border.highBorderRadius,
      ),
      child: CupertinoButton(
        onPressed: widget.isActive ? widget.onTap : null,
        color: widget.isActive ? Colors.white : const Color(0xFF404040),
        borderRadius: context.border.highBorderRadius,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Text(
          widget.hintText,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
