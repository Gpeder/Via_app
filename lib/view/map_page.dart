import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' hide Path;
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:via_app/enum/category_color.dart';
import 'package:via_app/model/categories.dart';
import 'package:via_app/model/volunteer_opportunity.dart';
import 'package:via_app/utils/color.dart';
import 'package:via_app/widgets/marker.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  bool showCard = false;
  VolunteerOpportunity? selectedOpportunity;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryList = categories;
    final _selectedCategoryIndex = 0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actionsPadding: const EdgeInsets.only(right: 16),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        automaticallyImplyActions: false,
        title: CoreInput(
          fillColor: AppColors.white,
          hint: 'Buscar oportunidades ...',
          onChanged: (value) {},
          size: CoreInputSize.lg,
          variant: CoreInputVariant.filled,
          controller: _searchController,
          prefixIcon: LucideIcons.search,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: SizedBox(
            height: 40,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final cat = categoryList[index];
                return CoreChip(
                  activeColor: AppColors.primary,
                  fillColor: AppColors.white,
                  radius: CoreChipRadius.lg,
                  selected: _selectedCategoryIndex == index,
                  label: cat.name,
                  size: CoreChipSize.lg,
                  variant: CoreChipVariant.filled,
                );
              },
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              AppColors.black.withValues(alpha: 0.1),
              BlendMode.darken,
            ),
            child: FlutterMap(
              mapController: MapController(),
              options: MapOptions(
                initialCenter: LatLng(-23.55052, -46.63331),
                initialZoom: 15,
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.doubleTapDragZoom,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png",
                  subdomains: const ['a', 'b', 'c', 'd'],
                  userAgentPackageName: 'com.gustavo.via',
                  retinaMode: RetinaMode.isHighDensity(context),
                ),
                MarkerLayer(
                  markers: mockOpportunities.map((item) {
                    final cat = CategoryColor.fromDisplayName(item.category);
                    return Marker(
                      point: LatLng(item.latitude, item.longitude),
                      width: 80,
                      height: 80,
                      child: CoreMarker(
                        distance: "${item.distance} km",
                        color: cat.textColor,
                        onTap: () {
                          setState(() {
                            selectedOpportunity = item;
                            showCard = true;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            bottom: showCard ? 90 : -200,
            left: 20,
            right: 20,
            child: showCard && selectedOpportunity != null
                ? OpportunityCard(
                    item: selectedOpportunity!,
                    onClose: () {
                      setState(() {
                        showCard = false;
                      });
                    },
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class OpportunityCard extends StatelessWidget {
  final VolunteerOpportunity item;
  final VoidCallback onClose;

  const OpportunityCard({super.key, required this.item, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final cat = CategoryColor.fromDisplayName(item.category);
    final textTheme = Theme.of(context).textTheme;

    return CoreCard(
      padding: const EdgeInsets.all(12),
      variant: CoreCardVariant.elevated,
      backgroundColor: AppColors.white,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image(
                image: NetworkImage(item.imageUrl),
                width: 140,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          color: cat.bgColor,
                        ),
                        child: Text(
                          item.category,
                          style: textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: cat.textColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: onClose,
                        child: const Icon(
                          LucideIcons.x,
                          size: 14,
                          color: AppColors.gray200,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.title,
                    style: textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    item.organizationName,
                    style: textTheme.bodySmall!.copyWith(
                      color: AppColors.gray200,
                    ),
                  ),
                  SizedBox(height: 10),
                  CoreButton(
                    variant: CoreButtonVariant.primary,
                    size: CoreButtonSize.lg,
                    label: 'Ver detalhes',
                    fullWidth: true,
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/detailcard',
                        arguments: item,
                      );
                    },
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
