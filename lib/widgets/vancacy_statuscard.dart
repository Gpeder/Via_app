import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:via_app/utils/color.dart';
import 'package:via_app/widgets/stack_avatar.dart';

class VacancyStatusCard extends StatelessWidget {
  final String amountCurrent;
  final String amountMax;

  const VacancyStatusCard({
    super.key,
    required this.amountCurrent,
    required this.amountMax,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CoreCard(
      radius: CoreCardRadius.lg,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      variant: CoreCardVariant.outline,
      backgroundColor: AppColors.gray100.withValues(alpha: .2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const StackAvatar(),
              const SizedBox(width: 10),
              Text('$amountCurrent já inscritos', style: textTheme.bodyLarge),
              const Spacer(),
              Text(
                '$amountMax vagas no total',
                style: textTheme.bodyMedium!.copyWith(color: AppColors.gray200),
              ),
            ],
          ),
          const SizedBox(height: 20),
          LinearProgressIndicator(
            value: int.parse(amountCurrent) / int.parse(amountMax),
          ),
          const SizedBox(height: 10),
          Text(
            '⚡ Apenas ${int.parse(amountMax) - int.parse(amountCurrent)} vagas restantes!',
            style: textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}