import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:via_app/utils/color.dart';
import 'package:via_app/widgets/icon_text.dart';

class SecondaryVolunteerCard extends StatelessWidget {
  final String image;
  final String title;
  final String name;
  final String distance;
  final String time;
  final String category;
  final VoidCallback onTap;

  const SecondaryVolunteerCard({
    super.key,
    required this.image,
    required this.title,
    required this.name,
    required this.distance,
    required this.time,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: CoreCard(
        onTap: onTap,
        variant: .elevated,
        padding: .zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  clipBehavior: .antiAlias,
                  borderRadius: .only(
                    topLeft: .circular(12),
                    topRight: .circular(12),
                  ),
                  child: Image.network(
                    image,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 10,
                  child: Container(
                    padding: .symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: .all(.circular(12)),
                      color: AppColors.white,
                    ),
                    child: Text(
                      category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextTheme.of(context).bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.gray200,
                      ),
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
                    style: TextTheme.of(context).titleMedium,
                  ),
                  SizedBox(height: 10),

                  Row(
                    mainAxisSize: .min,
                    children: [
                      IconText(
                        text: '$distance km',
                        icon: FontAwesomeIcons.locationDot,
                      ),
                      SizedBox(width: 10),
                      IconText(text: time, icon: FontAwesomeIcons.clock),
                    ],
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