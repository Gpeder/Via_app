import 'dart:core';
import 'dart:math';

import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
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

  String _calculateDuration(String start, String end) {
    try {
      final startParts = start.split(':');
      final endParts = end.split(':');

      final startHour = int.parse(startParts[0]);
      final startMinute = int.parse(startParts[1]);

      final endHour = int.parse(endParts[0]);
      final endMinute = int.parse(endParts[1]);

      final startTotalMinutes = startHour * 60 + startMinute;
      final endTotalMinutes = endHour * 60 + endMinute;

      int diffMinutes = endTotalMinutes - startTotalMinutes;
      if (diffMinutes < 0) {
        diffMinutes += 24 * 60;
      }

      final hours = diffMinutes / 60.0;

      if (hours == hours.toInt()) {
        return '${hours.toInt()} h';
      } else {
        return '${hours.toStringAsFixed(1).replaceAll('.', ',')} h';
      }
    } catch (e) {
      return '';
    }
  }

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
    final item =
        ModalRoute.of(context)!.settings.arguments as VolunteerOpportunity;
    final cat = CategoryColor.fromDisplayName(item.category);
    final textTheme = Theme.of(context).textTheme;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context, item),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderImage(context, item, cat, height),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleSection(item, textTheme),
                  const SizedBox(height: 20),
                  _buildStatsCards(item, textTheme),
                  const SizedBox(height: 20),
                  VacancyStatusCard(
                    amountCurrent: item.currentVolunteers.toString(),
                    amountMax: item.requiredVolunteers.toString(),
                  ),
                  const SizedBox(height: 20),
                  _buildDescriptionSection(item, textTheme),
                  const SizedBox(height: 20),
                  _buildLocationSection(item, textTheme),
                  const SizedBox(height: 20),
                  _buildOrganizationCard(item, textTheme),
                  const SizedBox(height: 20),
                  CoreButton(
                    fullWidth: true,
                    label: 'Escolher horário',
                    variant: CoreButtonVariant.primary,
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/selectdate',
                        arguments: item,
                      );
                    },
                    size: CoreButtonSize.lg,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    VolunteerOpportunity item,
  ) {
    return AppBar(
      actionsPadding: const EdgeInsets.only(right: 16),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: UnconstrainedBox(
        child: CoreIconButton(
          icon: LucideIcons.chevronLeft,
          variant: CoreIconButtonVariant.secondary,
          borderRadius: 100,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      actions: [
        CoreIconButton(
          icon: LucideIcons.share2,
          variant: CoreIconButtonVariant.secondary,
          borderRadius: 100,
          onPressed: () {},
        ),
        const SizedBox(width: 10),
        CoreIconButton(
          variant: CoreIconButtonVariant.secondary,
          icon: item.isFavorite ? Icons.favorite : LucideIcons.heart,
          iconColor: item.isFavorite ? AppColors.destructive : null,
          borderRadius: 100,
          onPressed: () {
            setState(() {
              item.isFavorite = !item.isFavorite;
            });
          },
        ),
      ],
    );
  }

  Widget _buildHeaderImage(
    BuildContext context,
    VolunteerOpportunity item,
    CategoryColor cat,
    double height,
  ) {
    return Stack(
      children: [
        Container(
          height: height * .3,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              scale: 1,
              fit: BoxFit.cover,
              image: NetworkImage(item.imageUrl),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: cat.bgColor,
            ),
            child: Text(
              item.category,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: AppColors.white,
            ),
            child: Text(
              '⭐ ${item.rating} (${item.voteCount})',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleSection(VolunteerOpportunity item, TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.title, style: textTheme.titleLarge),
        const SizedBox(height: 5),
        Text(
          item.organizationName,
          style: textTheme.bodyLarge!.copyWith(color: AppColors.gray200),
        ),
      ],
    );
  }

  Widget _buildStatsCards(VolunteerOpportunity item, TextTheme textTheme) {
    return Row(
      children: [
        Expanded(
          child: DescCard(
            textTheme: textTheme,
            title: '${item.distance} km',
            subtitle: 'de distancia',
            icon: LucideIcons.mapPin,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: DescCard(
            textTheme: textTheme,
            title: _calculateDuration(item.schedules.first.startTime, item.schedules.first.endTime),
            subtitle: 'de duração',
            icon: LucideIcons.clock,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: DescCard(
            textTheme: textTheme,
            title: '${item.requiredVolunteers} vagas',
            subtitle: 'de voluntários',
            icon: LucideIcons.users,
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection(
    VolunteerOpportunity item,
    TextTheme textTheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Descrição', style: textTheme.titleLarge),
        const SizedBox(height: 10),
        Text(
          item.description,
          style: textTheme.bodyLarge!.copyWith(color: AppColors.gray200),
        ),
      ],
    );
  }

  Widget _buildLocationSection(VolunteerOpportunity item, TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Localização', style: textTheme.titleLarge),
        const SizedBox(height: 10),
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
        const SizedBox(height: 10),
        IconText(text: item.location, icon: LucideIcons.mapPin),
      ],
    );
  }

  Widget _buildOrganizationCard(
    VolunteerOpportunity item,
    TextTheme textTheme,
  ) {
    return CoreCard(
      radius: CoreCardRadius.lg,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      variant: CoreCardVariant.outline,
      backgroundColor: AppColors.gray100.withValues(alpha: .2),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CoreAvatar(
          imageType: CoreAvatarImageType.network,
          src: item.logoUrl,
        ),
        title: Text(item.organizationName, style: textTheme.titleMedium),
        subtitle: Text(
          'Organização verificada ✓',
          style: textTheme.bodyMedium!.copyWith(color: AppColors.gray200),
        ),
      ),
    );
  }
}
