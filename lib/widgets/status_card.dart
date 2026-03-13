import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:via_app/utils/color.dart';
import 'package:via_app/widgets/icon_text.dart';

enum StatusCardType {
  agendada,
  cancelada,
  concluida;

  ({String label, Color bgColor, Color textColor}) get config => switch (this) {
    StatusCardType.agendada => (
      label: 'Agendada',
      bgColor: const Color(0xffDBEAFE),
      textColor: const Color(0xff2563EE),
    ),
    StatusCardType.cancelada => (
      label: 'Cancelada',
      bgColor: const Color(0xffFEE2E2),
      textColor: AppColors.destructive,
    ),
    StatusCardType.concluida => (
      label: 'Concluída',
      bgColor: const Color(0xffE8F5E9),
      textColor: AppColors.success,
    ),
  };
}

class CardStatus extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String organizationName;
  final String date;
  final String startTime;
  final String endTime;
  final StatusCardType status;

  const CardStatus({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.organizationName,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final config = status.config;

    return CoreCard(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      variant: CoreCardVariant.outline,
      backgroundColor: AppColors.white,
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Image.network(
                  imageUrl,
                  width: 140,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 2,
                      ),
                      Text(
                        organizationName,
                        style: textTheme.bodyMedium!.copyWith(
                          color: AppColors.gray200,
                        ),
                      ),
                      const SizedBox(height: 10),
                      IconText(text: date, icon: FontAwesomeIcons.calendar),
                      const SizedBox(height: 5),
                      IconText(
                        text: '$startTime - $endTime',
                        icon: FontAwesomeIcons.clock,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: config.bgColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Text(
                          config.label,
                          style: textTheme.bodyMedium!.copyWith(
                            color: config.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (status == StatusCardType.agendada)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: CoreButton(
                      label: 'Check-in',
                      icon: FontAwesomeIcons.check,
                      variant: CoreButtonVariant.primary,
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CoreButton(
                      label: 'Cancelar',
                      icon: FontAwesomeIcons.circleXmark,
                      variant: CoreButtonVariant.outline,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          if (status == StatusCardType.concluida)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CoreCard(
                backgroundColor: const Color(0xffF6F7F9),
                variant: CoreCardVariant.elevated,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Center(
                  child: Text(
                    '✨ Atividade concluída! Obrigada por fazer a diferença.',
                    style: textTheme.bodyMedium!.copyWith(
                      color: AppColors.gray200,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
