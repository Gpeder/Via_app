import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:via_app/model/categories.dart';
import 'package:via_app/model/volunteer_opportunity.dart';
import 'package:via_app/utils/color.dart';
import 'package:via_app/widgets/icon_text.dart';
import 'package:via_app/widgets/volunteer_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final categoryItem = categories;
    final allItems = mockOpportunities;

    final filteredItems = _selectedCategoryIndex == 0
        ? allItems
        : allItems
              .where(
                (item) =>
                    item.category == categoryItem[_selectedCategoryIndex].name,
              )
              .toList();

    return Scaffold(
      appBar: _appBar(textTheme),
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
                      size: .lg,
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

              SecondaryVolunteerCard(
                image:
                    'https://images.unsplash.com/photo-1516627145497-ae6968895b74?q=80&w=400',
                title: 'Teste',
                name: 'wddd',
                distance: '1.2',
                time: '2',
                category: 'tempo',
                onTap: () {},
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
                    time: '${item.startTime} - ${item.endTime}',
                    image: item.imageUrl,
                    onTap: () {},
                    amountCurrent: item.currentVolunteers.toString(),
                    amountMax: item.requiredVolunteers.toString(),
                    category: item.category,
                    rating: item.rating.toString(),
                    voteCount: item.voteCount.toString(),
                    favTap: () {},
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(TextTheme textTheme) {
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
          Text('Jossick Wilekenso 👋', style: textTheme.titleLarge),
        ],
      ),
      actions: [
        CoreAvatar.network(
          size: const Size(60, 60),
          placeholder: Center(child: Text('J')),
          'https://app.requestly.io/delay/2000/avatars.githubusercontent.com/u/124598?v=3',
          border: Border.all(color: AppColors.primary, width: 3),
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
                onSuffixTap: () {},
                size: CoreInputSize.lg,
                variant: CoreInputVariant.filled,
                controller: TextEditingController(),
                prefixIcon: FontAwesomeIcons.magnifyingGlass,
                suffixIcon: FontAwesomeIcons.sliders,
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

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
                child: Image.network(image, height: 150, width: double.infinity, fit: BoxFit.cover),
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
                    SizedBox(width: 20),
                    IconText(text: '$time h', icon: FontAwesomeIcons.clock),
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
