import 'package:flutter_bloc/flutter_bloc.dart';
import '../enum.dart';
import '../model/model.dart';
import 'api_event.dart';
import 'api_state.dart';
import '../api/api_service.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final ApiService apiService;
  int currentTabIndex = 0;
  final int itemsPerPage = 20;

  ApiBloc(this.apiService) : super(Initial()) {
    on<FetchEvent>((event, emit) async {
      emit(Loading());
      try {

        final data = await apiService.fetchUsers();
        emit(Loaded(data, 0, itemsPerPage));
      } catch (e) {
        emit(Error(e.toString()));
      }
    });

    on<SortEvent>((event, emit) async {
      if (state is Loaded) {

        List<Contact> allUsers = (state as Loaded).users;
        int startIndex = currentTabIndex * itemsPerPage;
        int endIndex = (startIndex + itemsPerPage > allUsers.length)
            ? allUsers.length
            : startIndex + itemsPerPage;

        List<Contact> tabUsers = allUsers.sublist(startIndex, endIndex);


        switch (event.sortBy) {
          case SortType.AtoZ:
            tabUsers.sort((a, b) => a.name.compareTo(b.name));
            break;
          case SortType.ZtoA:
            tabUsers.sort((a, b) => b.name.compareTo(a.name));
            break;
          case SortType.Contacts:
            tabUsers.sort((a, b) => a.contacts.compareTo(b.contacts));
            break;
        }

        allUsers.replaceRange(startIndex, endIndex, tabUsers);
        emit(Loaded(allUsers, currentTabIndex, itemsPerPage));
      }
    });

    on<ChangeTabEvent>((event, emit) async {
      if (state is Loaded) {
        currentTabIndex = event.tabIndex;
        emit(Loaded((state as Loaded).users, currentTabIndex, (state as Loaded).itemsPerPage));
      }
    });
  }
}
