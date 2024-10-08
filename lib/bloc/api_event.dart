import '../enum.dart';

abstract class ApiEvent {}

class FetchEvent extends ApiEvent {}

class SortEvent extends ApiEvent {
  final SortType sortBy;
  SortEvent(this.sortBy);
}

class ChangeTabEvent extends ApiEvent {
  final int tabIndex;
  ChangeTabEvent(this.tabIndex);
}
