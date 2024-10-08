import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/api_bloc.dart';
import '../bloc/api_event.dart';
import '../bloc/theme_bloc/theme_bloc.dart';
import '../bloc/theme_bloc/theme_event.dart';
import '../widget/contact_widget.dart';
import '../widget/sorting.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  void _showSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return SortingWidget(
          onSortSelected: (sortType) {
            context.read<ApiBloc>().add(SortEvent(sortType));
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              _showSortBottomSheet(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              context.read<ThemeBloc>().add(DarkAndLight());
            },
          ),
        ],
      ),
      body: const ContactTabView(),
    );
  }
}
