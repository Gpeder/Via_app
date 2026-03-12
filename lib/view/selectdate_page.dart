import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:via_app/enum/category_color.dart';

import 'package:via_app/helper/date_helper.dart';
import 'package:via_app/model/volunteer_opportunity.dart';
import 'package:via_app/utils/color.dart';
import 'package:via_app/widgets/icon_text.dart';
import 'package:via_app/widgets/selectable_schedule_card.dart';

class SelectdatePage extends StatefulWidget {
  const SelectdatePage({super.key});

  @override
  State<SelectdatePage> createState() => _SelectdatePageState();
}

class _SelectdatePageState extends State<SelectdatePage> {
  int? _selectedIndex;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final item =
          ModalRoute.of(context)!.settings.arguments as VolunteerOpportunity;
      if (item.currentVolunteers < item.requiredVolunteers && item.schedules.isNotEmpty) {
        _selectedIndex = 0;
      }
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final item =
        ModalRoute.of(context)!.settings.arguments as VolunteerOpportunity;

    return Scaffold(
      appBar: _buildAppBar(context, item),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderCard(context, item),
              const SizedBox(height: 20),
              Text(
                'Selecione um horário disponível',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _buildSchedulesList(item),
              ),
              const SizedBox(height: 20),
              _buildInstructionsCard(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  PreferredSizeWidget _buildAppBar(
      BuildContext context, VolunteerOpportunity item) {
    final textTheme = Theme.of(context).textTheme;
    return AppBar(
      elevation: 0,
      leading: UnconstrainedBox(
        child: CoreIconButton(
          size: .sm,
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
    );
  }

  Widget _buildHeaderCard(BuildContext context, VolunteerOpportunity item) {
    final textTheme = Theme.of(context).textTheme;
    final cat = CategoryColor.fromDisplayName(item.category);

    return CoreCard(
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
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
    );
  }

  Widget _buildSchedulesList(VolunteerOpportunity item) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: item.schedules.length,
      itemBuilder: (context, index) {
        final schedule = item.schedules[index];
        return SelectableScheduleCard(
          selected: _selectedIndex == index,
          onTap: () {
            setState(() {
              if (_selectedIndex == index) {
                _selectedIndex = null;
              } else {
                _selectedIndex = index;
              }
            });
          },
          onChanged: (value) {
            setState(() {
              if (value == true) {
                _selectedIndex = index;
              } else {
                _selectedIndex = null;
              }
            });
          },
          date: DateHelper.formatShortDate(schedule.date),
          time: ' ${schedule.startTime} - ${schedule.endTime}',
          vacancies: item.currentVolunteers,
        );
      },
    );
  }

  Widget _buildInstructionsCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CoreCard(
      backgroundColor: AppColors.gray100.withValues(alpha: .2),
      padding: .symmetric(horizontal: 16, vertical: 8),
      variant: CoreCardVariant.outline,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text('Oque esperar', style: textTheme.titleMedium),
          const SizedBox(height: 10),
          const IconText(
            size: .md,
            text: 'Leve roupas confortáveis e calçado fechado',
            icon: FontAwesomeIcons.circleCheck,
          ),
          const SizedBox(height: 5),
          const IconText(
            size: .md,
            text: 'Chegue 15 minutos antes do horário',
            icon: FontAwesomeIcons.circleCheck,
          ),
          const SizedBox(height: 5),
          const IconText(
            size: .md,
            text: 'Você receberá confirmação por e-mail',
            icon: FontAwesomeIcons.circleCheck,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
      child: CoreButton(
        variant: CoreButtonVariant.primary,
        size: .lg,
        label: 'Confirmar',
        onPressed: () {
          if (_selectedIndex != null) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
