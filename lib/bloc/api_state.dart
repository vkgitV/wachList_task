import '../model/model.dart';

abstract class ApiState {}

class Initial extends ApiState {}

class Loading extends ApiState {}

class Loaded extends ApiState {
  final List<Contact> users;
  final int currentTabIndex;
  final int itemsPerPage;

  Loaded(this.users, this.currentTabIndex, this.itemsPerPage);

  int get tabCount => (users.length / itemsPerPage).ceil();
}

class Error extends ApiState {
  final String message;
  Error(this.message);
}
