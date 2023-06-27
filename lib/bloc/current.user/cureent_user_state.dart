// ignore_for_file: must_be_immutable

part of 'cureent_user_bloc.dart';

abstract class CureentUserState extends Equatable {
  const CureentUserState();

  @override
  List<Object> get props => [];
}

enum RequestEtat { none, exist }

class CureentUserInitial extends CureentUserState {
  final UserModel userModel;
  final RequestEtat etat;

  CureentUserInitial({required this.userModel, required this.etat});
  @override
  List<Object> get props => [userModel, etat];
}
