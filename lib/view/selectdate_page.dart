import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:via_app/model/volunteer_opportunity.dart';
import 'package:via_app/utils/color.dart';

class SelectdatePage extends StatelessWidget {
  const SelectdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final item =
        ModalRoute.of(context)!.settings.arguments as VolunteerOpportunity;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: UnconstrainedBox(
          child: CoreIconButton(
            icon: FontAwesomeIcons.chevronLeft,
            variant: CoreIconButtonVariant.secondary,
            borderRadius: 100,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('Escolha um horário', style: textTheme.titleMedium),
          subtitle: Text(
            item.title,
            style: textTheme.bodyMedium!.copyWith(color: AppColors.gray200),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CoreCard(
                padding: .zero,
                variant: CoreCardVariant.outline,
                backgroundColor: AppColors.gray100.withValues(alpha: .2),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      child: Image(
                        image: NetworkImage(item.imageUrl),
                        width: 120,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: AppColors.primary,
                          ),
                          child: Text(
                            item.category,
                            style: TextTheme.of(context).bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item.title,
                          style: textTheme.titleMedium,
                          maxLines: 2,
                          softWrap: true,
                          overflow: .ellipsis,
                        ),
                        Text(
                          item.organizationName,
                          style: textTheme.bodyMedium!.copyWith(
                            color: AppColors.gray200,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text('Selecione um horário disponível', style: textTheme.titleMedium),
              SizedBox(height: 20),
              CoreCheckBox(value: true, onChanged: (value) {}),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
