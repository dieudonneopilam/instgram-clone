part of 'current_user_bloc.dart';

abstract class CurrentUserState extends Equatable {
  const CurrentUserState();

  @override
  List<Object> get props => [];
}

class CurrentUserInitial extends CurrentUserState {
  final UserModel user;
  CurrentUserInitial({required this.user});
  @override
  List<Object> get props => [user];
}
