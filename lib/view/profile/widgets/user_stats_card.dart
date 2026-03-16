import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:via_app/model/user_model.dart';
import 'package:via_app/utils/color.dart';

class UserStatsCard extends StatelessWidget {
  final UserProfile user;

  const UserStatsCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return CoreCard(
      radius: .lg,
      variant: .elevated,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _statItem(
              textTheme,
              const Color(0xff3e75ee),
              const Color(0xffE4EBFC),
              FontAwesomeIcons.clock,
              '${user.totalHours}H',
              'Horas',
            ),
            const CoreDivider.vertical(
              thickness: 1,
              color: AppColors.gray100,
            ),
            _statItem(
              textTheme,
              const Color(0xff49B771),
              const Color(0xffE2F3E8),
              FontAwesomeIcons.award,
              '${user.activitiesCount}',
              'Atividades',
            ),
            const CoreDivider.vertical(
              thickness: 1,
              color: AppColors.gray100,
            ),
            _statItem(
              textTheme,
              const Color(0xffFFC107),
              const Color(0xffFFF3E0),
              FontAwesomeIcons.star,
              '${user.impactPoints}',
              'Impacto',
            ),
          ],
        ),
      ),
    );
  }

  Widget _statItem(
    TextTheme textTheme,
    Color iconColor,
    Color bgColor,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
          child: Icon(icon, size: 20, color: iconColor),
        ),
        const SizedBox(height: 10),
        Text(title, style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w900)),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: textTheme.bodyLarge!.copyWith(color: AppColors.gray200),
        ),
      ],
    );
  }
}
