import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:via_app/utils/color.dart';

class SettingsSection extends StatelessWidget {
  final VoidCallback onLogout;

  const SettingsSection({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Configurações', style: textTheme.titleMedium),
        const SizedBox(height: 10),
        _configItem(
          textTheme,
          FontAwesomeIcons.bell,
          'Notificações',
          'Alerta de novas oportunidades',
        ),
        const SizedBox(height: 10),
        _configItem(
          textTheme,
          FontAwesomeIcons.locationDot,
          'Localização',
          'Atualizar minha cidade',
        ),
        _configItem(
          textTheme,
          FontAwesomeIcons.heart,
          'Causas favoritas',
          'Gerenciar interesses',
        ),
        _configItem(
          textTheme,
          FontAwesomeIcons.shield,
          'Privacidade',
          'Dados e segurança',
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onLogout,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade50,
              foregroundColor: Colors.red,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Sair da conta', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _configItem(
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
