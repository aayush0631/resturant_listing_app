import 'package:flutter/material.dart';

/// Reusable Icon + Text widget
class IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? iconColor;
  final double iconSize;
  final TextStyle? textStyle;

  const IconText({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor,
    this.iconSize = 15,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor ?? Colors.grey, size: iconSize),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: textStyle ?? const TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}
