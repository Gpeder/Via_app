import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:via_app/utils/color.dart';
import 'package:via_app/widgets/stack_avatar.dart';

class DetailcardPage extends StatelessWidget {
  const DetailcardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 16),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: UnconstrainedBox(
          child: CoreIconButton(
            icon: FontAwesomeIcons.chevronLeft,
            variant: CoreIconButtonVariant.secondary,
            borderRadius: 100,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: [
          CoreIconButton(
            icon: FontAwesomeIcons.shareNodes,
            variant: CoreIconButtonVariant.secondary,
            borderRadius: 100,
            onPressed: () {},
          ),
          SizedBox(width: 10),
          CoreIconButton(
            variant: CoreIconButtonVariant.secondary,
            icon: FontAwesomeIcons.heart,
            borderRadius: 100,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * .3,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  scale: 1,
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1559027615-cd4628902d4a?q=80&w=400',
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Distribuição de Alimentos',
                    style: textTheme.titleLarge,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Banco de Alimentos SP',
                    style: textTheme.bodyLarge!.copyWith(
                      color: AppColors.gray200,
                    ),
                  ),

                  SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: DescCard(
                          textTheme: textTheme,
                          title: '1,2 km',
                          subtitle: 'de distancia',
                          icon: FontAwesomeIcons.locationDot,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: DescCard(
                          textTheme: textTheme,
                          title: '3 h',
                          subtitle: 'de duração',
                          icon: FontAwesomeIcons.clock,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: DescCard(
                          textTheme: textTheme,
                          title: '6 vagas',
                          subtitle: 'de voluntários',
                          icon: FontAwesomeIcons.userGroup,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  VacancyStatusCard(amountCurrent: '10', amountMax: '20'),

                  SizedBox(height: 20),

                  Text('Descrição', style: textTheme.titleLarge),
                  SizedBox(height: 10),
                  Text(
                    'A distribuição de alimentos é um trabalho voluntário que consiste em distribuir alimentos para pessoas em situação de vulnerabilidade social. Os voluntários são responsáveis por separar, embalar e distribuir os alimentos para as pessoas que precisam.',
                    style: textTheme.bodyLarge!.copyWith(
                      color: AppColors.gray200,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Localização', style: textTheme.titleLarge),
                  SizedBox(height: 10),
                  Text(
                    'Rua das Flores, 123 - São Paulo - SP',
                    style: textTheme.bodyLarge!.copyWith(
                      color: AppColors.gray200,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

class StackAvatar extends StatelessWidget {
  const StackAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            CoreAvatar.network(
              size: const Size(30, 30),
              placeholder: Text('J'),
              'https://app.requestly.io/delay/2000/avatars.githubusercontent.com/u/124598?v=3',
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: CoreAvatar.network(
                size: const Size(30, 30),
                placeholder: Text('J'),
                'https://app.requestly.io/delay/2000/avatars.githubusercontent.com/u/124597?v=3',
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: CoreAvatar.network(
                size: const Size(30, 30),
                placeholder: Text('J'),
                'https://app.requestly.io/delay/2000/avatars.githubusercontent.com/u/124599?v=3',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

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
