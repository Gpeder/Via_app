import 'package:flutter/material.dart';

enum TextSize {
  md,
  lg,
}

class IconText extends StatelessWidget {
  final String text;
  final IconData icon;
  final TextSize size;
  final Color? iconColor;
  final Color? textColor;

  const IconText({
    super.key,
    required this.text,
    required this.icon,
    this.size = TextSize.md,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle;
    double iconSize;
    
    switch (size) {
      case TextSize.lg:
        textStyle = Theme.of(context).textTheme.bodyLarge!;
        iconSize = 20.0;
        break;
      case TextSize.md:
        textStyle = Theme.of(context).textTheme.bodyMedium!;
        iconSize = 16.0;
        break;
    }

    return Row(
      mainAxisSize: .min,
      children: [
        Icon(icon, size: iconSize, color: iconColor ?? textStyle.color),
        const SizedBox(width: 5),
        Text(
          text,
          style: textStyle.copyWith(color: textColor),
        ),
      ],
    );
  }
}