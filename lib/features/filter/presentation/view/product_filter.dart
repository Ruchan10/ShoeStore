import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductFilterView extends ConsumerStatefulWidget {
  const ProductFilterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductFilterViewState();
}

class _ProductFilterViewState extends ConsumerState<ProductFilterView> {
  final List<String> _selectedBrands = [];
  RangeValues _currentRangeValues = const RangeValues(0, 1750);
  String? _selectedSortOption;
  String? _selectedGenderOption;
  String? _selectedColorOption;

  void _toggleSelection(String brandName) {
    setState(() {
      if (_selectedBrands.contains(brandName)) {
        _selectedBrands.remove(brandName);
      } else {
        _selectedBrands.add(brandName);
      }
    });
  }

  void _selectSortOption(String label) {
    setState(() {
      _selectedSortOption = label;
    });
  }

  void _selectGenderOption(String label) {
    setState(() {
      _selectedGenderOption = label;
    });
  }

  void _selectColorOption(String label) {
    setState(() {
      _selectedColorOption = label;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Filter',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Brands',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      BrandItem(
                        brandName: 'NIKE',
                        logo: const AssetImage('assets/logos/nLogo.png'),
                        isSelected: _selectedBrands.contains('NIKE'),
                        onTap: _toggleSelection,
                        itemCount: '1001 Items',
                      ),
                      BrandItem(
                        brandName: 'Puma',
                        logo: const AssetImage('assets/logos/pumaLogo.jpg'),
                        isSelected: _selectedBrands.contains('Puma'),
                        onTap: _toggleSelection,
                        itemCount: '999 Items',
                      ),
                      BrandItem(
                        brandName: 'Adidas',
                        logo: const AssetImage('assets/logos/aLogo.jpg'),
                        isSelected: _selectedBrands.contains('Adidas'),
                        onTap: _toggleSelection,
                        itemCount: '11 Items',
                      ),
                      BrandItem(
                        brandName: 'Reebok',
                        logo: const AssetImage('assets/logos/rLogo.webp'),
                        isSelected: _selectedBrands.contains('Reebok'),
                        onTap: _toggleSelection,
                        itemCount: '8 Items',
                      ),
                      BrandItem(
                        brandName: 'Jordan',
                        logo: const AssetImage('assets/logos/jLogo.jpg'),
                        isSelected: _selectedBrands.contains('Jordan'),
                        onTap: _toggleSelection,
                        itemCount: '11 Items',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Price Range',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                RangeSlider(
                  values: _currentRangeValues,
                  min: 0,
                  max: 1750,
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                    });
                  },
                  divisions: 100,
                  labels: RangeLabels(
                    '\$${_currentRangeValues.start.toStringAsFixed(0)}',
                    '\$${_currentRangeValues.end.toStringAsFixed(0)}',
                  ),
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$0'),
                    Text('\$1750'),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Sort By',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    SortOption(
                      label: 'Most recent',
                      isSelected: _selectedSortOption == 'Most recent',
                      onSelect: _selectSortOption,
                    ),
                    SortOption(
                      label: 'Lowest price',
                      isSelected: _selectedSortOption == 'Lowest price',
                      onSelect: _selectSortOption,
                    ),
                    SortOption(
                      label: 'Highest price',
                      isSelected: _selectedSortOption == 'Highest price',
                      onSelect: _selectSortOption,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Gender',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    GenderOption(
                      label: 'Man',
                      isSelected: _selectedGenderOption == 'Man',
                      onSelect: _selectGenderOption,
                    ),
                    GenderOption(
                      label: 'Woman',
                      isSelected: _selectedGenderOption == 'Woman',
                      onSelect: _selectGenderOption,
                    ),
                    GenderOption(
                      label: 'Unisex',
                      isSelected: _selectedGenderOption == 'Unisex',
                      onSelect: _selectGenderOption,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Color',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    ColorOption(
                      label: 'Black',
                      color: Colors.black,
                      isSelected: _selectedColorOption == 'Black',
                      onSelect: _selectColorOption,
                    ),
                    ColorOption(
                      label: 'White',
                      color: Colors.white,
                      isSelected: _selectedColorOption == 'White',
                      onSelect: _selectColorOption,
                    ),
                    ColorOption(
                      label: 'Red',
                      color: Colors.red,
                      isSelected: _selectedColorOption == 'Red',
                      onSelect: _selectColorOption,
                    ),
                    // ColorOption(
                    //   label: 'Green',
                    //   color: Colors.green,
                    //   isSelected: _selectedColorOption == 'Green',
                    //   onSelect: _selectColorOption,
                    // ),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.black),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                      ),
                      child: const Text('RESET (4)'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                      ),
                      child: const Text('APPLY'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BrandItem extends StatelessWidget {
  final String brandName;
  final ImageProvider logo;
  final String itemCount;
  final bool isSelected;
  final ValueChanged<String> onTap;

  const BrandItem({
    super.key,
    required this.brandName,
    required this.logo,
    required this.isSelected,
    required this.onTap,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(brandName),
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: logo,
                  backgroundColor: Colors.grey[300],
                ),
                if (isSelected)
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 16,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              brandName,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SortOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<String> onSelect;

  const SortOption({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      showCheckmark: false,
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        onSelect(label);
      },
      selectedColor: Colors.black,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Make border more oval
        side: BorderSide(
          color: isSelected ? Colors.black : Colors.grey,
          width: 1,
        ),
      ),
    );
  }
}

class GenderOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<String> onSelect;

  const GenderOption({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      showCheckmark: false,
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        onSelect(label);
      },
      selectedColor: Colors.black,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Make border more oval
        side: BorderSide(
          color: isSelected ? Colors.black : Colors.grey,
          width: 1,
        ),
      ),
    );
  }
}

class ColorOption extends StatelessWidget {
  final String label;
  final Color color;
  final bool isSelected;
  final ValueChanged<String> onSelect;

  const ColorOption({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelect,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      showCheckmark: false,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(
                right: 8), // Space between the color circle and the text
            width: 20, // Width of the color circle
            height: 20, // Height of the color circle
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              border: Border.all(
                color: isSelected ? Colors.black : Colors.grey,
                width: isSelected ? 2.5 : 1,
              ),
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? Colors.black
                  : Colors.grey, // Color when selected
            ),
          ),
        ],
      ),
      selected: isSelected,
      onSelected: (bool selected) {
        onSelect(label);
      },
      selectedColor: Colors.white,
      backgroundColor: Colors.white,
      side: BorderSide(
        color: isSelected ? Colors.black : Colors.grey, // Border color
        width: isSelected ? 2.5 : 1, // Bolder border if selected
      ),
      labelStyle: TextStyle(
        fontWeight: isSelected
            ? FontWeight.bold
            : FontWeight.normal, // Bolder text if selected
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
