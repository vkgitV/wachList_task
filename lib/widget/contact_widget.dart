import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/api_bloc.dart';
import '../bloc/api_state.dart';
import '../bloc/api_event.dart';
import '../model/model.dart';

class ContactTabView extends StatelessWidget {
  const ContactTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.light;

    return BlocBuilder<ApiBloc, ApiState>(
      builder: (context, state) {
        if (state is Loaded) {
          final List<Contact> users = state.users;
          final int itemsPerPage = state.itemsPerPage;
          final int tabCount = state.tabCount;
          print('tabCount$tabCount');
          final int currentTabIndex = state.currentTabIndex;


          return DefaultTabController(
            length: tabCount,
            child: Column(
              children: [
                TabBar(
                  labelColor: Colors.blue,
                  dividerColor: Theme.of(context).primaryColorLight,
                  // isScrollable: true,
                  onTap: (index) {
                    context.read<ApiBloc>().add(ChangeTabEvent(index));
                  },
                  tabs: List.generate(tabCount, (index) => Tab(text: 'Contact ${index + 1}'),),
                  // tabAlignment: TabAlignment.start,
                ),
                Expanded(
                  child: TabBarView(
                    children: List.generate(tabCount, (index) {
                      if (index == currentTabIndex) {
                        int startIndex = index * itemsPerPage;
                        print('startIndex $startIndex');
                        int endIndex = (startIndex + itemsPerPage > users.length)
                            ? users.length
                            : startIndex + itemsPerPage;
                        print('endIndex $endIndex');
                        final tabUsers = users.sublist(startIndex, endIndex);
                        print('tabUsers $tabUsers');

                        return ListView.builder(
                          itemCount: tabUsers.length,
                          itemBuilder: (context, i) {
                            final user = tabUsers[i];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color:isDarkMode ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColorDark,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            user.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        user.contacts,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
                  ),
                ),
              ],
            ),
          );
        } else if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is Error) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
