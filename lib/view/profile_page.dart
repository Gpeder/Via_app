import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:via_app/utils/color.dart';
import 'package:via_app/widgets/icon_text.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        automaticallyImplyActions: false,
        actionsPadding: const EdgeInsets.only(right: 16),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.penToSquare),
            color: AppColors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 300,
                  padding: .symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(gradient: AppColors.gradient),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [_profileHeader(textTheme)],
                  ),
                ),
                SizedBox(height: 70),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text('Sobre mim', style: textTheme.titleMedium),
                      SizedBox(height: 10),
                      Text(
                        'Estudante de Psicologia apaixonada por causas sociais e meio ambiente. Acredito que pequenas ações transformam o mundo.',
                        style: textTheme.bodyMedium!.copyWith(
                          color: AppColors.gray200,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Text(
                            'Causas que me movem',
                            style: textTheme.titleMedium,
                          ),
                          CoreButton(
                            onPressed: () {},
                            variant: .link,
                            label: 'Editar',
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: AppColors.gray100,
                        ),
                        child: Text(
                          'Meio Ambiente',
                          style: TextTheme.of(context).bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.gray200,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 300,
              left: 20,
              right: 20,
              child: FractionalTranslation(
                translation: Offset(0, -0.5),
                child: CoreCard(
                  radius: .lg,
                  variant: .elevated,
                  padding: .symmetric(horizontal: 20, vertical: 16),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: .spaceEvenly,
                      children: [
                        _titleContainer(
                          textTheme,
                          Color(0xff3e75ee),
                          Color(0xffE4EBFC),
                          FontAwesomeIcons.clock,
                          '24h',
                          'Horas',
                        ),
                        const CoreDivider.vertical(
                          thickness: 1,
                          color: AppColors.gray100,
                        ),
                        _titleContainer(
                          textTheme,
                          Color(0xff49B771),
                          Color(0xffE2F3E8),
                          FontAwesomeIcons.award,
                          '8',
                          'Atividades',
                        ),
                        const CoreDivider.vertical(
                          thickness: 1,
                          color: AppColors.gray100,
                        ),
                        _titleContainer(
                          textTheme,
                          Color(0xffFFC107),
                          Color(0xffFFF3E0),
                          FontAwesomeIcons.star,
                          '420',
                          'Impacto',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _titleContainer(
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
          padding: .all(10),
          decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
          child: Icon(icon, size: 20, color: iconColor),
        ),
        SizedBox(height: 5),
        Text(title, style: textTheme.titleLarge!.copyWith(fontWeight: .w900)),
        SizedBox(height: 5),
        Text(
          subtitle,
          style: textTheme.bodyLarge!.copyWith(color: AppColors.gray200),
        ),
      ],
    );
  }

  Row _profileHeader(TextTheme textTheme) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: AppColors.background,
            shape: BoxShape.circle,
          ),
          child: CoreAvatar.network(
            shape: .circle,
            size: const Size(80, 80),
            placeholder: Center(child: Text('J')),
            'https://app.requestly.io/delay/2000/avatars.githubusercontent.com/u/124598?v=3',
          ),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Gustavo Henrique',
              style: textTheme.titleLarge!.copyWith(color: AppColors.white),
            ),
            SizedBox(height: 5),
            IconText(
              icon: FontAwesomeIcons.locationDot,
              text: 'São Paulo - SP',
              iconColor: AppColors.background,
              textColor: AppColors.background,
            ),
          ],
        ),
      ],
    );
  }
}
