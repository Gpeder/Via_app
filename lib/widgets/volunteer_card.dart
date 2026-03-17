import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart' show LucideIcons;
import 'package:shimmer/shimmer.dart';
import 'package:via_app/enum/category_color.dart';
import 'package:via_app/utils/color.dart';
import 'package:via_app/widgets/icon_text.dart';
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
      radius: CoreCardRadius.lg,
      onTap: onTap,
      variant: CoreCardVariant.elevated,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: FutureBuilder(
                    future: Future.delayed(const Duration(seconds: 3)),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Shimmer(
                          gradient: AppColors.getShimmerGradient(context),
                          child: Container(
                            height: 180,
                            width: double.infinity,
                            color: Colors.white,
                          ),
                        );
                      }
                      return Image.network(
                        image,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
              ),
              Positioned(
                left: 10,
                top: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
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
                  variant: CoreIconButtonVariant.secondary,
                  icon: LucideIcons.heart,
                  onPressed: favTap,
                ),
              ),

              Positioned(
                left: 10,
                bottom: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconText(text: '$distance km', icon: LucideIcons.mapPin),
                    const SizedBox(width: 20),
                    IconText(text: '$time h', icon: LucideIcons.clock),
                    Spacer(),
                    StackDetailAvatar(
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
