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

  // Add state variables for selected price range
  RangeValues _currentRangeValues = const RangeValues(200, 750);

  void _toggleSelection(String brandName) {
    setState(() {
      if (_selectedBrands.contains(brandName)) {
        _selectedBrands.remove(brandName);
      } else {
        _selectedBrands.add(brandName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
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
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // Replace these with your actual BrandItem widgets
                        // Example:
                        // BrandItem(
                        //   brandName: 'NIKE',
                        //   logo: AssetImage('assets/logos/nikeLogo.png'),
                        //   isSelected: _selectedBrands.contains('NIKE'),
                        //   onTap: _toggleSelection,
                        //   itemCount: '1001 Items',
                        // ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$${_currentRangeValues.start.toStringAsFixed(0)}'),
                      Text('\$${_currentRangeValues.end.toStringAsFixed(0)}'),
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
                  const Wrap(
                    spacing: 8,
                    children: [
                      SortOption(label: 'Most recent', isSelected: true),
                      SortOption(label: 'Lowest price'),
                      SortOption(label: 'Highest price'),
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
                  const Wrap(
                    spacing: 8,
                    children: [
                      // GenderOption(label: 'Man', isSelected: true),
                      // GenderOption(label: 'Woman'),
                      // GenderOption(label: 'Unisex'),
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
                  const Wrap(
                    spacing: 8,
                    children: [
                      // ColorOption(
                      //     label: 'Black',
                      //     color: Colors.black,
                      //     isSelected: true),
                      // ColorOption(label: 'White', color: Colors.white),
                      // ColorOption(label: 'Red', color: Colors.red),
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
      ),
    );
  }
}

class SortOption extends StatelessWidget {
  final String label;
  final bool isSelected;

  const SortOption({super.key, required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {},
      selectedColor: Colors.black,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
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
    required this.color,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? color : Colors.grey, // Text color when selected
        ),
      ),
      selected: isSelected,
      onSelected: (bool selected) => onSelect(label),
      selectedColor: Colors.white, // Background color when selected
      backgroundColor: Colors.white, // Default background color
      side: BorderSide(
        color: isSelected ? color : Colors.grey, // Border color
        width: isSelected ? 2.5 : 1, // Bolder border if selected
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Oval shape
      ),
      labelStyle: TextStyle(
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, // Bolder text if selected
      ),
      // Remove any check mark or additional icons
    );
  }
}
