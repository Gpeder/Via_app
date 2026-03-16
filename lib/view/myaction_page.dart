import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:via_app/helper/date_helper.dart';
import 'package:via_app/model/volunteer_status.dart';
import 'package:via_app/utils/color.dart';
import 'package:via_app/widgets/status_card.dart';

class MyactionPage extends StatefulWidget {
  const MyactionPage({super.key});

  @override
  State<MyactionPage> createState() => _MyactionPageState();
}

class _MyactionPageState extends State<MyactionPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final item = mockUserActions;
    final agendadas = item
        .where((e) => e.status == ActionStatus.agendada)
        .toList();
    final concluidas = item
        .where((e) => e.status == ActionStatus.concluida)
        .toList();
    final canceladas = item
        .where((e) => e.status == ActionStatus.cancelada)
        .toList();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
          automaticallyImplyActions: false,
          automaticallyImplyLeading: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Minhas ações', style: textTheme.titleLarge),
              Text(
                '${agendadas.length} compromisso${agendadas.length == 1 ? '' : 's'} agendado${agendadas.length == 1 ? '' : 's'}',
                style: textTheme.bodyLarge!.copyWith(color: AppColors.gray200),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: CoreCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  variant: CoreCardVariant.elevated,
                  backgroundColor: const Color(0xffFFE8A3),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: _cardItem(
                            textTheme,
                            concluidas.length.toString(),
                            'Concluídas',
                          ),
                        ),
                        const CoreDivider.vertical(
                          thickness: 2,
                          color: AppColors.primary,
                          radius: BorderRadius.all(Radius.circular(20)),
                        ),
                        Expanded(
                          child: _cardItem(
                            textTheme,
                            agendadas.length.toString(),
                            'Agendadas',
                          ),
                        ),
                        const CoreDivider.vertical(
                          thickness: 2,
                          color: AppColors.primary,
                          radius: BorderRadius.all(Radius.circular(20)),
                        ),
                        Expanded(child: _cardItem(textTheme, '2', 'Horas')),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TabBar(
                indicatorColor: AppColors.primary,
                labelColor: AppColors.primary,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: AppColors.gray100,
                unselectedLabelColor: AppColors.gray200,
                labelStyle: textTheme.bodyLarge,
                unselectedLabelStyle: textTheme.bodyLarge,
                tabs: const [
                  Tab(text: 'Próximas'),
                  Tab(text: 'Agendadas'),
                  Tab(text: 'Canceladas'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildStatusList(agendadas),
                    _buildStatusList(concluidas),
                    _buildStatusList(canceladas),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusList(List<UserAction> actions) {
    if (actions.isEmpty) {
      return Center(
        child: Text(
          'Nenhuma atividade encontrada',
          style: TextStyle(color: AppColors.gray200),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: CardStatus(
            title: action.opportunity.title,
            organizationName: action.opportunity.organizationName,
            date: DateHelper.formatShortDate(action.schedule.date),
            startTime: action.schedule.startTime.toString(),
            endTime: action.schedule.endTime.toString(),
            status: StatusCardType.values.byName(action.status.name),
            imageUrl: action.opportunity.imageUrl,
          ),
        );
      },
    );
  }

  Column _cardItem(TextTheme textTheme, String title, String subtitle) {
    return Column(
      children: [
        Text(
          title,
          style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          style: textTheme.bodyLarge!.copyWith(color: AppColors.gray200),
        ),
      ],
    );
  }
}
