part of 'bottom_navigation_bar_bloc.dart';

abstract class BottomNavigationBarEvent extends Equatable {
  const BottomNavigationBarEvent();

  @override
  List<Object> get props => [];
}

class ChangedIndex extends BottomNavigationBarEvent {
  final int index;
  ChangedIndex({required this.index});
}
