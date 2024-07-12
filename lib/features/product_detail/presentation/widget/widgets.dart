import 'package:flutter/material.dart';

class SizeOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<String> onSelect;

  const SizeOption({
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
      shape: CircleBorder(
        side: BorderSide(
          color: isSelected ? Colors.black : Colors.grey,
          width: 0.5,
        ),
      ),
    );
  }
}

class ColorOption extends StatelessWidget {
  final Color color;
  final String label;
  final bool isSelected;
  final ValueChanged<String> onSelect;

  const ColorOption({
    super.key,
    required this.color,
    required this.label,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      showCheckmark: false,
      avatar: isSelected
          ? CircleAvatar(
              backgroundColor: color,
              child: const Icon(Icons.check, color: Colors.white),
            )
          : null,
      label: const Text(""),
      selected: isSelected,
      onSelected: (bool selected) {
        onSelect(label);
      },
      selectedColor: color,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25), // Circular shape
        side: BorderSide(
          color: isSelected ? Colors.black : Colors.grey,
          width: 0.5,
        ),
      ),
    );
  }
}

class ColorPicker extends StatelessWidget {
  final String? selectedColor;
  final Function(String) onSelect;

  const ColorPicker({
    super.key,
    required this.selectedColor,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 132,
      height: 40,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 20,
            spreadRadius: 0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildColorOption(Colors.white, 'white'),
            _buildColorOption(Colors.black, 'black'),
            _buildColorOption(Colors.blue, 'blue'),
            _buildColorOption(Colors.green, 'green'),
          ],
        ),
      ),
    );
  }

  Widget _buildColorOption(Color color, String label) {
    return GestureDetector(
      onTap: () {
        onSelect(label);
      },
      child: Container(
        width: 20,
        height: 20,
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey),
          color: color,
        ),
        child: Center(
          child: Visibility(
            visible: selectedColor == label,
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),
      ),
    );
  }
}
