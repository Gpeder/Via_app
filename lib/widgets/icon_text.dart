import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final String text;
  final IconData icon;
  final double iconSize;
  final Color? iconColor;
  final Color? textColor;

  const IconText({
    super.key,
    required this.text,
    required this.icon,
    this.iconSize = 14,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: iconSize,
          color: iconColor ?? textTheme.bodyMedium!.color,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: textTheme.bodyMedium!.copyWith(color: textColor),
        ),
      ],
    );
  }
}