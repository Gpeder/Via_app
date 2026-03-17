import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:via_app/enum/category_color.dart';
import 'package:via_app/model/user_model.dart';
import 'package:via_app/utils/color.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final user = mockCurrentUser;
  late List<String> _selectedInterests;

  @override
  void initState() {
    super.initState();
    _selectedInterests = List.from(user.interests);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(
            LucideIcons.chevronLeft,
            color: AppColors.black,
            size: 16,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Editar Perfil',
          style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _avatar(textTheme),
              const SizedBox(height: 20),
              CoreInput(
                label: 'Nome completo',
                hint: user.name,
                size: CoreInputSize.lg,
                variant: CoreInputVariant.filled,
                controller: TextEditingController(text: user.name),
              ),
              const SizedBox(height: 20),
              CoreInput(
                label: 'Cidade',
                hint: user.location,
                size: CoreInputSize.lg,
                variant: CoreInputVariant.filled,
                controller: TextEditingController(text: user.location),
              ),
              const SizedBox(height: 20),
              CoreTextArea(
                label: 'Sobre mim',
                hint: user.bio,
                size: CoreInputSize.lg,
                variant: CoreInputVariant.filled,
                controller: TextEditingController(text: user.bio),
              ),
              SizedBox(height: 20),
              Text('Causas que me movem', style: textTheme.titleMedium),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: CategoryColor.values.map((category) {
                  final bool isActive = _selectedInterests.contains(category.displayName);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isActive) {
                          _selectedInterests.remove(category.displayName);
                        } else {
                          _selectedInterests.add(category.displayName);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        color: isActive ? category.bgColor : AppColors.gray100,
                      ),
                      child: Text(
                        category.displayName,
                        style: textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isActive ? category.textColor : AppColors.gray200,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text('Preferências de notificação', style: textTheme.titleMedium),
              SizedBox(height: 10),
              _notificationItem(textTheme, 'Novas oportunidades', true),
              SizedBox(height: 20),
              _notificationItem(textTheme, 'Lembretes de voluntariado', false),
              SizedBox(height: 20),
              _notificationItem(textTheme, 'Novidades das ONGs que sigo', true),
              SizedBox(height: 20),
              CoreButton(
                label: 'Salvar alterações',
                onPressed: () {},
                size: CoreButtonSize.lg,
                fullWidth: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _notificationItem(
    TextTheme textTheme,
    String title,
    bool value, {
    Function(bool)? onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: textTheme.bodyLarge),
        CoreSwitch(value: value, onChanged: onChanged),
      ],
    );
  }

  Center _avatar(TextTheme textTheme) {
    return Center(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(user.imageUrl ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: -12,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 2),
                  ),
                  child: const Icon(
                    LucideIcons.camera,
                    size: 20,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Alterar foto',
            style: textTheme.bodyLarge!.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
