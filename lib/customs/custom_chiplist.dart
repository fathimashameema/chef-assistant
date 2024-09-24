import 'package:chef_assistant/customs/colors.dart';
import 'package:flutter/material.dart';

class CustomChipList extends StatefulWidget {
  final List<String> listOfChipNames;
  final int initialSelectedIndex;

  const CustomChipList({super.key, 
    required this.listOfChipNames,
    this.initialSelectedIndex = 0,
  });

  @override
  CustomChipListState createState() => CustomChipListState();
}

class CustomChipListState extends State<CustomChipList> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 40,
      alignment: WrapAlignment.center,
      children: List.generate(widget.listOfChipNames.length, (index) {
        return ChoiceChip(
          label: Text(widget.listOfChipNames[index]),
          selected: selectedIndex == index,
          onSelected: (bool selected) {
            setState(() {
              // Prevent deselecting the last selected chip
              if (selectedIndex != index) {
                selectedIndex = index;
              }
            });
          },
          selectedColor: PresetColors.fadedgrey,
          disabledColor: PresetColors.nudegrey,
          backgroundColor: PresetColors.nudegrey,
          labelStyle:const TextStyle(color: PresetColors.white),
          showCheckmark: false,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          side: BorderSide.none,
          padding:const EdgeInsets.all(10),
        );
      }),
    );
  }
}
