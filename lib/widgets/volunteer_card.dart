import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:via_app/enum/category_color.dart';
import 'package:via_app/utils/color.dart';
import 'package:via_app/widgets/icon_text.dart';
import 'package:via_app/widgets/iconbutton.dart';
import 'package:via_app/widgets/stack_avatar.dart';

class VolunteerCard extends StatelessWidget {
  final String title;
  final String image;
  final String name;
  final String distance;
  final String category;
  final String rating;
  final String voteCount;
  final String time;
  final VoidCallback favTap;
  final VoidCallback onTap;
  final String amountCurrent;
  final String amountMax;

  const VolunteerCard({
    super.key,
    required this.title,
    required this.name,
    required this.distance,
    required this.time,
    required this.image,
    required this.onTap,
    required this.amountCurrent,
    required this.amountMax,
    required this.category,
    required this.rating,
    required this.voteCount,
    required this.favTap,
  });

  @override
  Widget build(BuildContext context) {
    final cat = CategoryColor.fromDisplayName(category);

    return CoreCard(
      onTap: onTap,
      variant: .elevated,
      padding: .zero,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Stack(
            children: [
              ClipRRect(
                clipBehavior: .antiAlias,
                borderRadius: .only(
                  topLeft: .circular(12),
                  topRight: .circular(12),
                ),
                child: Image(
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  image: NetworkImage(image),
                ),
              ),
              Positioned(
                left: 10,
                top: 10,
                child: Container(
                  padding: .symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: .all(.circular(12)),
                    color: cat.bgColor,
                  ),
                  child: Text(
                    category,
                    style: TextTheme.of(context).bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: cat.textColor,
                    ),
                  ),
                ),
              ),

              Positioned(
                right: 10,
                top: 10,
                child: CoreIconButton(
                  variant: .secondary,
                  icon: FontAwesomeIcons.heart,
                  onPressed: favTap,
                ),
              ),

              Positioned(
                left: 10,
                bottom: 10,
                child: Container(
                  padding: .symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: .all(.circular(12)),
                    color: AppColors.white,
                  ),
                  child: Text(
                    '⭐ $rating ($voteCount)',
                    style: TextTheme.of(
                      context,
                    ).bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const .symmetric(horizontal: 12, vertical: 10),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  title,
                  style: TextTheme.of(context).titleLarge,
                ),
                Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  name,
                  style: TextTheme.of(
                    context,
                  ).bodyLarge!.copyWith(color: AppColors.gray200),
                ),
                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    IconText(
                      text: '$distance km',
                      icon: FontAwesomeIcons.locationDot,
                    ),
                    SizedBox(width: 20),
                    IconText(text: '$time h', icon: FontAwesomeIcons.clock),
                    Spacer(),
                    StackAvatar(
                      amountCurrent: amountCurrent,
                      amountMax: amountMax,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
