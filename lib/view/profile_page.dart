import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:via_app/model/user_model.dart';
import 'package:via_app/utils/color.dart';
import 'package:via_app/widgets/icon_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = mockCurrentUser;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actionsPadding: const EdgeInsets.only(right: 16),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.penToSquare),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(gradient: AppColors.gradient),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [_buildHeader(textTheme)],
                  ),
                ),
                const SizedBox(height: 70),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sobre mim', style: textTheme.titleMedium),
                      const SizedBox(height: 10),
                      Text(
                        user.bio,
                        style: textTheme.bodyMedium!.copyWith(
                          color: AppColors.gray200,
                        ),
                      ),
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: AppColors.gray100,
                        ),
                        child: Text(
                          'Meio Ambiente',
                          style: textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.gray200,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildAwardCard(textTheme),
                      const SizedBox(height: 20),
                      _buildSettingsSection(textTheme),
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
                translation: const Offset(0, -0.5),
                child: _buildStatsCard(textTheme),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(TextTheme textTheme) {
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
            placeholder: Center(child: Text(user.name[0])),
            user.imageUrl ?? '',
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: textTheme.titleLarge!.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: 5),
            IconText(
              icon: FontAwesomeIcons.locationDot,
              text: user.location,
              iconColor: AppColors.background,
              textColor: AppColors.background,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsCard(TextTheme textTheme) {
    return CoreCard(
      radius: .lg,
      variant: .elevated,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: .spaceEvenly,
          children: [
            _buildStatItem(
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
            _buildStatItem(
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
            _buildStatItem(
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

  Widget _buildStatItem(
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
        Text(title,
            style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w900)),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: textTheme.bodyLarge!.copyWith(color: AppColors.gray200),
        ),
      ],
    );
  }

  Widget _buildAwardCard(TextTheme textTheme) {
    return CoreCard(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xffF2BE24), Color(0xffFFE8A3)],
      ),
      radius: .lg,
      variant: .elevated,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: AppColors.gray100,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              FontAwesomeIcons.award,
              size: 20,
              color: AppColors.gray200,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Voluntária Ativa 🏆',
                  style: textTheme.titleMedium,
                ),
                Text(
                  'Você está entre os top 10% voluntários da sua cidade!',
                  style: textTheme.bodyMedium!.copyWith(
                    color: AppColors.gray200,
                  ),
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Configurações', style: textTheme.titleMedium),
        const SizedBox(height: 10),
        _buildConfigItem(
          textTheme,
          FontAwesomeIcons.bell,
          'Notificações',
          'Alerta de novas oportunidades',
        ),
        const SizedBox(height: 10),
        _buildConfigItem(
          textTheme,
          FontAwesomeIcons.locationDot,
          'Localização',
          'Atualizar minha cidade',
        ),
        _buildConfigItem(
          textTheme,
          FontAwesomeIcons.heart,
          'Causas favoritas',
          'Gerenciar interesses',
        ),
        _buildConfigItem(
          textTheme,
          FontAwesomeIcons.shield,
          'Privacidade',
          'Dados e segurança',
        ),
        const SizedBox(height: 20),
        CoreButton(
          variant: .destructive,
          fullWidth: true,
          size: .lg,
          label: 'Sair da conta',
          onPressed: () {},
        )
      ],
    );
  }

  Widget _buildConfigItem(
    TextTheme textTheme,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: () {},
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: textTheme.titleSmall),
      subtitle: Text(subtitle, style: textTheme.bodyMedium),
      leading: Container(
        height: 50,
        width: 50,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.gray100.withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20),
      ),
      trailing: const Padding(
        padding: EdgeInsets.only(right: 8),
        child: Icon(
          FontAwesomeIcons.chevronRight,
          size: 16,
          color: Color.fromRGBO(158, 158, 158, 0.5),
        ),
      ),
    );
  }
}
