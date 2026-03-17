import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:via_app/utils/color.dart';
import 'package:via_app/widgets/icon_text.dart';

class SelectableScheduleCard extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  final ValueChanged<bool?> onChanged;
  final String date;
  final String time;
  final int vacancies;

  const SelectableScheduleCard({
    super.key,
    required this.selected,
    required this.onTap,
    required this.onChanged,
    required this.date,
    required this.time,
    required this.vacancies,
  });

  @override
  Widget build(BuildContext context) {
    return CoreCard(
      variant: CoreCardVariant.outline,
      radius: CoreCardRadius.lg,
      backgroundColor: selected
          ? AppColors.primary.withValues(alpha: .2)
          : AppColors.gray100.withValues(alpha: .2),
      padding: EdgeInsets.zero,
      child: ListTile(
        onTap: onTap,
        title: IconText(
          text: date,
          icon: LucideIcons.calendar1,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: IconText(
            text: time,
            icon: LucideIcons.clock,
          ),
        ),
        leading: CoreCheckBox(value: selected, onChanged: onChanged),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.success.withValues(alpha: .5),
              width: 1,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: Color(0xffdcfce7),
          ),
          child: Text(
            '$vacancies vagas',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.success,
            ),
          ),
        ),
      ),
    );
  }
}
