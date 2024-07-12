import 'package:flutter/material.dart';





class CategorySelector extends StatelessWidget {
  final List<String> categories = ['All', 'Nike', 'Jordan', 'Adidas', 'Reebok'];
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((category) {
            final bool isSelected = category == selectedCategory;
            return GestureDetector(
              onTap: () {
                onCategorySelected(category);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                child: Text(
                  category,
                  style: TextStyle(
                    height: 0.07,
                    letterSpacing: 0.20,
                    fontSize: 20,
                    fontFamily: 'Urbanist',
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                    color: isSelected ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}