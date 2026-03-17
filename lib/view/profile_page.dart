import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart' show LucideIcons;
import 'package:via_app/enum/category_color.dart';
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
            icon: const Icon(LucideIcons.pencil),
            color: AppColors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/edit_profile');
            },
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Causas que me movem',
                            style: textTheme.titleMedium,
                          ),
                          CoreButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/edit_profile');
                            },
                            variant: CoreButtonVariant.link,
                            label: 'Editar',
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: CategoryColor.values
                            .where((category) {
                              return user.interests.contains(
                                category.displayName,
                              );
                            })
                            .map((category) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                  color: category.bgColor,
                                ),
                                child: Text(
                                  category.displayName,
                                  style: textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: category.textColor,
                                  ),
                                ),
                              );
                            })
                            .toList(),
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
            shape: BoxShape.circle,
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
              icon: LucideIcons.mapPin,
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
      radius: CoreCardRadius.lg,
      variant: CoreCardVariant.elevated,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatItem(
              textTheme,
              const Color(0xff3e75ee),
              const Color(0xffE4EBFC),
              LucideIcons.clock,
              '${user.totalHours}H',
              'Horas',
            ),
            const CoreDivider.vertical(thickness: 1, color: AppColors.gray100),
            _buildStatItem(
              textTheme,
              const Color(0xff49B771),
              const Color(0xffE2F3E8),
              LucideIcons.graduationCap,
              '${user.activitiesCount}',
              'Atividades',
            ),
            const CoreDivider.vertical(thickness: 1, color: AppColors.gray100),
            _buildStatItem(
              textTheme,
              const Color(0xffFFC107),
              const Color(0xffFFF3E0),
              LucideIcons.star,
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
        Text(
          title,
          style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w900),
        ),
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
      radius: CoreCardRadius.lg,
      variant: CoreCardVariant.elevated,
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
              LucideIcons.graduationCap,
              size: 20,
              color: AppColors.gray200,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Voluntária Ativa 🏆', style: textTheme.titleMedium),
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
          LucideIcons.bell,
          'Notificações',
          'Alerta de novas oportunidades',
        ),
        const SizedBox(height: 10),
        _buildConfigItem(
          textTheme,
          LucideIcons.mapPin,
          'Localização',
          'Atualizar minha cidade',
        ),
        _buildConfigItem(
          textTheme,
          LucideIcons.heart,
          'Causas favoritas',
          'Gerenciar interesses',
        ),
        _buildConfigItem(
          textTheme,
          LucideIcons.shield,
          'Privacidade',
          'Dados e segurança',
        ),
        const SizedBox(height: 20),
        CoreButton(
          variant: CoreButtonVariant.destructive,
          fullWidth: true,
          size: CoreButtonSize.lg,
          label: 'Sair da conta',
          onPressed: () {},
        ),
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
          LucideIcons.chevronRight,
          size: 16,
          color: Color.fromRGBO(158, 158, 158, 0.5),
        ),
      ),
    );
  }
}
