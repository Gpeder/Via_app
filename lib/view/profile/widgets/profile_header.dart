import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:via_app/model/user_model.dart';
import 'package:via_app/utils/color.dart';
import 'package:via_app/widgets/icon_text.dart';

class ProfileHeader extends StatelessWidget {
  final UserProfile user;

  const ProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
}
