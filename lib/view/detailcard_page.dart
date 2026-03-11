import 'dart:core';
import 'dart:math';

import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:via_app/enum/category_color.dart';
import 'package:via_app/utils/color.dart';
import 'package:via_app/widgets/desc_card.dart';
import 'package:via_app/widgets/icon_text.dart';
import 'package:via_app/widgets/vancacy_statuscard.dart';
import 'package:via_app/model/volunteer_opportunity.dart';

class DetailcardPage extends StatefulWidget {
  const DetailcardPage({super.key});

  @override
  State<DetailcardPage> createState() => _DetailcardPageState();
}

class _DetailcardPageState extends State<DetailcardPage> {
  late LatLng _randomLocation;

  @override
  void initState() {
    super.initState();
    final random = Random();
    final lat = -23.5505 + (random.nextDouble() - 0.5) * 0.1;
    final lng = -46.6333 + (random.nextDouble() - 0.5) * 0.1;
    _randomLocation = LatLng(lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as VolunteerOpportunity;
    final cat = CategoryColor.fromDisplayName(item.category);
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
            Stack(
              children: [
                Container(
                  height: height * .3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      scale: 1,
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        item.imageUrl,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: cat.bgColor,
                    ),
                    child: Text(
                      item.category,
                      style: TextTheme.of(context).bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: cat.textColor,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: AppColors.white,
                    ),
                    child: Text(
                      '⭐ ${item.rating} (${item.voteCount})',
                      style: TextTheme.of(
                        context,
                      ).bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: textTheme.titleLarge,
                  ),
                  SizedBox(height: 5),
                  Text(
                    item.organizationName,
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
                          title: '${item.distance} km',
                          subtitle: 'de distancia',
                          icon: FontAwesomeIcons.locationDot,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: DescCard(
                          textTheme: textTheme,
                          title: '${item.startTime}-${item.endTime}',
                          subtitle: 'horário',
                          icon: FontAwesomeIcons.clock,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: DescCard(
                          textTheme: textTheme,
                          title: '${item.requiredVolunteers} vagas',
                          subtitle: 'de voluntários',
                          icon: FontAwesomeIcons.userGroup,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  VacancyStatusCard(amountCurrent: item.currentVolunteers.toString(), amountMax: item.requiredVolunteers.toString()),

                  SizedBox(height: 20),

                  Text('Descrição', style: textTheme.titleLarge),
                  SizedBox(height: 10),
                  Text(
                    item.description,
                    style: textTheme.bodyLarge!.copyWith(
                      color: AppColors.gray200,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Localização', style: textTheme.titleLarge),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: _randomLocation,
                          zoom: 20,
                        ),
                        markers: {
                          Marker(
                            markerId: const MarkerId('random_loc'),
                            position: _randomLocation,
                          ),
                        },
                        zoomControlsEnabled: false,
                        myLocationButtonEnabled: false,
                        scrollGesturesEnabled: false,
                        zoomGesturesEnabled: false,
                        tiltGesturesEnabled: false,
                        rotateGesturesEnabled: false,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  IconText(
                    text: item.location,
                    icon: FontAwesomeIcons.locationDot,
                  ),
                  SizedBox(height: 20),

                  CoreCard(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    variant: CoreCardVariant.outline,
                    backgroundColor: AppColors.gray100.withValues(alpha: .2),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CoreIconButton(icon: FontAwesomeIcons.building),
                      title: Text(
                        item.organizationName,
                        style: textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        'Organização verificada ✓',
                        style: textTheme.bodyMedium!.copyWith(
                          color: AppColors.gray200,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  CoreButton(
                    fullWidth: true,
                    label: 'Escolher horário',
                    variant: CoreButtonVariant.primary,
                    onPressed: () {},
                    size: CoreButtonSize.lg,
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
