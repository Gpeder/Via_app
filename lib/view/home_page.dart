import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:via_app/model/categories.dart';
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
                      time: '${item.startTime}-${item.endTime}',
                      category: item.category,
                      onTap: () {},
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
                    time: '${item.startTime}-${item.endTime}',
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
                size: CoreInputSize.lg,
                variant: CoreInputVariant.filled,
                controller: TextEditingController(),
                prefixIcon: FontAwesomeIcons.magnifyingGlass,
                suffixIcon: FontAwesomeIcons.sliders,
                onSuffixTap: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => bottoModal(),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Container bottoModal() => Container(
    padding: const EdgeInsets.only(top: 20, bottom: 20),
    child: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(FontAwesomeIcons.sliders, size: 20),
                    SizedBox(width: 10),
                    Text('Filtros', style: TextTheme.of(context).titleLarge),
                    Spacer(),
                    CoreIconButton(
                      icon: FontAwesomeIcons.xmark,
                      variant: CoreIconButtonVariant.secondary,
                      size: CoreIconButtonSize.sm,
                      borderRadius: 100,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                CoreDivider.horizontal(thickness: 0.5),
              ],
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Categoria', style: TextTheme.of(context).titleMedium),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 35,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (context, index) => SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final cat = categories[index];
                        return CoreChip(
                          label: cat.name,
                          size: CoreChipSize.lg,
                          variant: CoreChipVariant.filled,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Distância máxima',
                        style: TextTheme.of(context).titleMedium,
                      ),
                      Text(
                        '10 km',
                        style: TextTheme.of(
                          context,
                        ).bodyLarge!.copyWith(color: AppColors.primaryDark),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  CoreSlider(
                    value: 0,
                    min: 0,
                    max: 100,
                    onChanged: (value) {},
                    activeColor: AppColors.primary,
                    thumbColor: AppColors.primary,
                    inactiveColor: AppColors.gray100,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text('0 km', style: TextTheme.of(context).bodyMedium),
                      Spacer(),
                      Text('10 km', style: TextTheme.of(context).bodyMedium),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('Categoria', style: TextTheme.of(context).titleMedium),
                  SizedBox(height: 10),
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 45,
                    ),
                    children: [
                      CoreChip(
                        label: 'Qualquer duração',
                        size: CoreChipSize.lg,
                        variant: CoreChipVariant.filled,
                      ),
                      CoreChip(
                        label: 'Até 2h',
                        size: CoreChipSize.lg,
                        variant: CoreChipVariant.filled,
                      ),
                      CoreChip(
                        label: 'Até 4h',
                        size: CoreChipSize.lg,
                        variant: CoreChipVariant.filled,
                      ),
                      CoreChip(
                        label: 'Dia todo',
                        size: CoreChipSize.lg,
                        variant: CoreChipVariant.filled,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('Dias da semana', style: TextTheme.of(context).titleMedium),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 10,
                    children: [
                      'Qualquer dia', 'Segunda', 'Terça', 'Quarta',
                      'Quinta', 'Sexta', 'Sábado', 'Domingo'
                    ].map((day) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CoreChip(
                          label: day,
                          size: CoreChipSize.lg,
                          selected: day == 'Qualquer dia',
                          variant: CoreChipVariant.filled,
                        ),
                      ],
                    )).toList(),
                  ),
                  SizedBox(height: 30),
                  CoreButton(
                    label: 'Aplicar',
                    size: CoreButtonSize.lg,
                    fullWidth: true,
                    variant: CoreButtonVariant.primary,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
