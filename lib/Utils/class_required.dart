import 'package:flutter/material.dart';

class MyDropdown extends StatelessWidget {
  final List<PriorityClass> priorityList;
  final void Function(PriorityClass?)? onChanged;
  final PriorityClass? initialValue;

  const MyDropdown({super.key, 
    required this.priorityList,
    this.onChanged,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<PriorityClass>(
      value: initialValue,
      onChanged: onChanged,
      items: priorityList.map((PriorityClass selectedPriority) {
        return DropdownMenuItem<PriorityClass>(
          value: selectedPriority,
          child: Text(selectedPriority.name),
        );
      }).toList(),
    );
  }
}



class PriorityClass {
 final int id;
  final String name;

  PriorityClass({required this.id, required this.name});

  static List<PriorityClass> fromList(List<Map<String, dynamic>> itemList) {
    return itemList.map((item) => PriorityClass(id: item['id'], name: item['name'])).toList();
  }
}
