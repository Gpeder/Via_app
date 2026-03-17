import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:via_app/enum/category_color.dart';
import 'package:via_app/helper/date_helper.dart';
import 'package:via_app/model/volunteer_opportunity.dart';
import 'package:via_app/utils/color.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final item =
        ModalRoute.of(context)!.settings.arguments as VolunteerOpportunity;
    final cat = CategoryColor.fromDisplayName(item.category);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 100, color: AppColors.primary),
              const SizedBox(height: 20),
              Text('Vaga confirmada! 🎉', style: textTheme.titleLarge),
              const SizedBox(height: 10),
              Text(
                'Você confirmou sua vaga para a oportunidade de voluntariado.',
                style: textTheme.bodyMedium!.copyWith(color: AppColors.gray200),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              CoreCard(
                radius: CoreCardRadius.lg,
                variant: CoreCardVariant.elevated,
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: Stack(
                        children: [
                          Image(
                            image: NetworkImage(item.imageUrl),
                            colorBlendMode: BlendMode.darken,
                            color: AppColors.black.withValues(alpha: .3),
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.titleMedium!.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  item.organizationName,
                                  style: textTheme.bodyMedium!.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Positioned(
                            top: 10,
                            left: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                color: cat.bgColor,
                              ),
                              child: Text(
                                item.category,
                                style: textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: cat.textColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoCard(
                            textTheme,
                            item,
                            'Data',
                            LucideIcons.calendar,
                            DateHelper.formatShortDate(item.schedules[0].date),
                          ),
                          const SizedBox(height: 10),
                          _infoCard(
                            textTheme,
                            item,
                            'Horário',
                            LucideIcons.clock,
                            '${item.schedules[0].startTime} - ${item.schedules[0].endTime}',
                          ),
                          const SizedBox(height: 10),
                          _infoCard(
                            textTheme,
                            item,
                            'Local',
                            LucideIcons.mapPin,
                            item.location,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Compartilhe sua participação e inspire pessoas! 🌟',
                style: textTheme.bodyMedium!.copyWith(
                  color: AppColors.gray200,
                ),
              ),
              const SizedBox(height: 10),
              CoreButton(
                variant: CoreButtonVariant.secondary,
                fullWidth: true,
                size: CoreButtonSize.lg,
                icon: LucideIcons.share2,
                label: 'Compartilhar nas redes sociais',
                onPressed: () {},
              ),
              const SizedBox(height: 40),
              CoreButton(
                variant: CoreButtonVariant.primary,
                fullWidth: true,
                size: CoreButtonSize.lg,
                label: 'Ver minhas ações',
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              CoreButton(
                variant: CoreButtonVariant.link,
                fullWidth: true,
                size: CoreButtonSize.lg,
                label: 'Voltar para a página inicial',
                onPressed: () {
                  Navigator.pushNamed(context, '/root');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _infoCard(
    TextTheme textTheme,
    VolunteerOpportunity item,
    String title,
    IconData icon,
    String subtitle,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: .3),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(icon, size: 20),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.bodyMedium!.copyWith(color: AppColors.gray200),
            ),
            Text(subtitle, style: textTheme.titleSmall),
          ],
        ),
      ],
    );
  }
}
