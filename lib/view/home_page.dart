import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:via_app/model/categories.dart';
import 'package:via_app/model/user_model.dart';
import 'package:via_app/model/volunteer_opportunity.dart';
import 'package:via_app/utils/color.dart';
import 'package:via_app/widgets/secondary_volunteer_card.dart';
import 'package:via_app/widgets/volunteer_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedCategoryIndex = 0;
  double _maxDistance = 10;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final categoryItem = categories;
    final allItems = mockOpportunities;
    final profile = mockCurrentUser;

    final filteredItems = _selectedCategoryIndex == 0
        ? allItems
        : allItems
              .where(
                (item) =>
                    item.category == categoryItem[_selectedCategoryIndex].name,
              )
              .toList();

    return Scaffold(
      appBar: _appBar(textTheme, profile),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              SizedBox(
                height: 35,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryItem.length,
                  itemBuilder: (context, index) {
                    final category = categoryItem[index];
                    return CoreChip(
                      radius: CoreChipRadius.lg,
                      size: CoreChipSize.lg,
                      selected: _selectedCategoryIndex == index,
                      onSelected: (value) {
                        setState(() {
                          _selectedCategoryIndex =
                              _selectedCategoryIndex == index ? 0 : index;
                        });
                      },
                      label: '${category.name}  ${category.icon}',
                    );
                  },
                ),
              ),
              SizedBox(height: 20),

              Text('🌱 Causas para explorar', style: textTheme.titleMedium),
              SizedBox(height: 10),

              SizedBox(
                height: 240,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: allItems.where((e) => e.isDestaque).length,
                  itemBuilder: (context, index) {
                    final destaques = allItems
                        .where((e) => e.isDestaque)
                        .toList();
                    final item = destaques[index];
                    return SecondaryVolunteerCard(
                      image: item.imageUrl,
                      title: item.title,
                      name: item.organizationName,
                      distance: item.distance.toString(),
                      time: '${item.schedules.first.startTime}-${item.schedules.first.endTime}',
                      category: item.category,
                      onTap: () {
                        Navigator.pushNamed(context, '/detailcard', arguments: item);
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedCategoryIndex == 0
                        ? 'Todas as oportunidades'
                        : categoryItem[_selectedCategoryIndex].name,
                    style: textTheme.titleMedium,
                  ),
                  Text(
                    '${filteredItems.length} encontrada${filteredItems.length == 1 ? '' : 's'}',
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
              SizedBox(height: 10),
              ListView.separated(
                padding: .zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return VolunteerCard(
                    title: item.title,
                    name: item.organizationName,
                    distance: item.distance.toString(),
                    time: '${item.schedules.first.startTime}-${item.schedules.first.endTime}',
                    image: item.imageUrl,
                    onTap: () {
                      Navigator.pushNamed(context, '/detailcard', arguments: item);
                    },
                    amountCurrent: item.currentVolunteers.toString(),
                    amountMax: item.requiredVolunteers.toString(),
                    category: item.category,
                    rating: item.rating.toString(),
                    voteCount: item.voteCount.toString(),
                    favTap: () {
                      setState(() {
                        item.isFavorite = !item.isFavorite;
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //!App bar 
  AppBar _appBar(TextTheme textTheme, UserProfile profile) {
    return AppBar(
      forceMaterialTransparency: true,
      actionsPadding: const EdgeInsets.only(right: 16),
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Boa tarde,',
            style: textTheme.bodyLarge!.copyWith(color: AppColors.gray200),
          ),
          Text('${profile.name} 👋', style: textTheme.titleLarge),
        ],
      ),
      actions: [
        FutureBuilder(
          future: Future.delayed(const Duration(seconds: 3)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Shimmer(
                gradient: AppColors.getShimmerGradient(context),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }
            return CoreAvatar.network(
              size: const Size(60, 60),
              placeholder: Center(child: Text('J')),
              'https://app.requestly.io/delay/2000/avatars.githubusercontent.com/u/124598?v=3',
              border: Border.all(color: AppColors.primary, width: 3),
            );
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 25),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CoreInput(
                hint: 'Buscar oportunidades ...',
                onChanged: (value) {},
                size: CoreInputSize.lg,
                variant: CoreInputVariant.filled,
                controller: TextEditingController(),
                prefixIcon: LucideIcons.search,
                suffixIcon: LucideIcons.slidersHorizontal,
                onSuffixTap: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => buildFilterModal(context),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFilterModal(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setModalState) {
        return Container(
          padding: const EdgeInsets.only(top: 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildModalHeader(context),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCategoriesSection(context),
                        const SizedBox(height: 24),
                        _buildDistanceSection(context, setModalState),
                        const SizedBox(height: 24),
                        _buildDurationSection(context),
                        const SizedBox(height: 24),
                        _buildDaysOfWeekSection(context),
                        const SizedBox(height: 32),
                        CoreButton(
                          label: 'Aplicar',
                          size: CoreButtonSize.lg,
                          fullWidth: true,
                          variant: CoreButtonVariant.primary,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildModalHeader(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(LucideIcons.slidersHorizontal, size: 20),
              const SizedBox(width: 12),
              Text('Filtros', style: textTheme.titleLarge),
              const Spacer(),
              CoreIconButton(
                icon: LucideIcons.x,
                variant: CoreIconButtonVariant.secondary,
                size: CoreIconButtonSize.sm,
                borderRadius: 100,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const CoreDivider.horizontal(thickness: 0.5),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final categoryList = categories;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Categoria', style: textTheme.titleMedium),
        const SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categoryList.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final cat = categoryList[index];
              return CoreChip(
                selected: _selectedCategoryIndex == index,
                label: cat.name,
                size: CoreChipSize.lg,
                variant: CoreChipVariant.filled,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDistanceSection(BuildContext context, StateSetter setModalState) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Distância máxima', style: textTheme.titleMedium),
            Text(
              '${_maxDistance.toInt()} km',
              style: textTheme.bodyLarge?.copyWith(
                color: AppColors.primaryDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        CoreSlider(
          value: _maxDistance,
          min: 0,
          max: 100,
          onChanged: (value) {
            setModalState(() {
              _maxDistance = value;
            });
          },
          activeColor: AppColors.primary,
          thumbColor: AppColors.primary,
          inactiveColor: AppColors.gray100,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text('0 km', style: textTheme.bodyMedium),
            const Spacer(),
            Text('100 km', style: textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }

  Widget _buildDurationSection(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tempo de voluntariado', style: textTheme.titleMedium),
        const SizedBox(height: 12),
        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: 45,
          ),
          children: [
            'Qualquer duração',
            'Até 2h',
            'Até 4h',
            'Dia todo',
          ].map((duration) => CoreChip(
            label: duration,
            size: CoreChipSize.lg,
            selected: duration == 'Qualquer duração',
            variant: CoreChipVariant.filled,
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildDaysOfWeekSection(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dias da semana', style: textTheme.titleMedium),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 12,
          children: [
            'Qualquer dia', 'Seg', 'Ter', 'Qua',
            'Qui', 'Sex', 'Sab', 'Dom',
          ].map((day) => UnconstrainedBox(
                child: CoreChip(
                  label: day,
                  size: CoreChipSize.lg,
                  selected: day == 'Qualquer dia',
                  variant: CoreChipVariant.filled,
                ),
              )).toList(),
        ),
      ],
    );
  }
}