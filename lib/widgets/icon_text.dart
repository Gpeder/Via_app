import 'package:flutter/material.dart';
import 'package:via_app/utils/color.dart';

class IconText extends StatelessWidget {
  final String text;
  final IconData icon;

  const IconText({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.gray200),
        SizedBox(width: 5),
        Text(
          text,
          style: TextTheme.of(
            context,
          ).bodyMedium!.copyWith(color: AppColors.gray200),
        ),
      ],
    );
  }
}