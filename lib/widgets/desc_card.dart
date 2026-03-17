import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:via_app/utils/color.dart';

class DescCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const DescCard({
    super.key,
    required this.textTheme,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return CoreCard(
      radius: CoreCardRadius.lg,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      variant: CoreCardVariant.outline,
      backgroundColor: AppColors.gray100.withValues(alpha: .2),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          SizedBox(height: 10),
          Text(
            title,
            style: textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            subtitle,
            style: textTheme.bodyMedium!.copyWith(color: AppColors.gray200),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}