import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:via_app/utils/color.dart';
import 'package:via_app/widgets/icon_text.dart';

class MyactionPage extends StatelessWidget {
  const MyactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
                '1 compromisso agendado',
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
                  backgroundColor: Color(0xffFFE8A3),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: _cardItem(textTheme, '2', 'Concluídas'),
                        ),
                        const CoreDivider.vertical(
                          thickness: 1.0,
                          color: AppColors.primaryDark,
                          radius: BorderRadius.all(Radius.circular(20)),
                        ),
                        Expanded(child: _cardItem(textTheme, '2', 'Agendadas')),
                        const CoreDivider.vertical(
                          thickness: 1.0,
                          color: AppColors.primaryDark,
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
                    SingleChildScrollView(
                      padding: .symmetric(horizontal: 16, vertical: 20),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              CardStatus(),
                              SizedBox(height: 10),
                              CardStatus(),
                              SizedBox(height: 10),
                              CardStatus(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Center(child: Text('Lista de agendadas')),
                    const Center(child: Text('Resumo de horas')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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

class CardStatus extends StatelessWidget {
  const CardStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CoreCard(
      padding: .symmetric(horizontal: 10, vertical: 10),
      variant: CoreCardVariant.outline,
      backgroundColor: AppColors.white,
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: .all(Radius.circular(12)),
                child: Image.network(
                  'https://app.requestly.io/delay/2000/avatars.githubusercontent.com/u/124598?v=3',
                  width: 140,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: .only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Plantio de Árvores', style: textTheme.titleMedium),
                    Text(
                      'Instituto verde vida',
                      style: textTheme.bodyMedium!.copyWith(
                        color: AppColors.gray200,
                      ),
                    ),
                    SizedBox(height: 10),
                    IconText(
                      text: 'Dom, 8 mar',
                      icon: FontAwesomeIcons.calendar,
                    ),
                    SizedBox(height: 5),
                    IconText(text: '8:00 - 11:00', icon: FontAwesomeIcons.clock),
                    SizedBox(height: 10),
                    Container(
                      padding: .symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Color(0xffE8F5E9),
                        borderRadius: .all(Radius.circular(12)),
                      ),
                      child: Text('Confirmado', style: textTheme.bodyMedium),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: CoreButton(
                  label: 'Check-in',
                  icon: FontAwesomeIcons.check,
                  variant: CoreButtonVariant.primary,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: CoreButton(
                  label: 'Cancelar',
                  icon: FontAwesomeIcons.circleCheck,
                  variant: CoreButtonVariant.outline,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
