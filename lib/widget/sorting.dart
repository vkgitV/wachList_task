import 'package:flutter/material.dart';
import '../bloc/api_event.dart';
import '../enum.dart';

class SortingWidget extends StatelessWidget {
  final Function(SortType) onSortSelected;

  const SortingWidget({super.key, required this.onSortSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Sort Contacts',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('Sort by Name (A-Z)'),
            onTap: () {
              onSortSelected(SortType.AtoZ);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Sort by Name (Z-A)'),
            onTap: () {
              onSortSelected(SortType.ZtoA);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Sort by Contacts'),
            onTap: () {
              onSortSelected(SortType.Contacts);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
