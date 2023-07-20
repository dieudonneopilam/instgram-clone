part of 'current_user_bloc.dart';

abstract class CurrentUserEvent extends Equatable {
  const CurrentUserEvent();

  @override
  List<Object> get props => [];
}

class OnChanged extends CurrentUserEvent {}
