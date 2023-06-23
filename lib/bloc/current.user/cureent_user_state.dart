part of 'cureent_user_bloc.dart';

abstract class CureentUserState extends Equatable {
  const CureentUserState();

  @override
  List<Object> get props => [];
}

class CureentUserInitial extends CureentUserState {
  String i = 'aucun';
  final AuthMethods _authMethods = AuthMethods();
  UserModel? user;
  UserModel get getUser => user!;
  // Future<String> refreshUser() async {
  //   UserModel userModel = await _authMethods.getUserDetails();
  //   user = userModel;
  //   i = user!.email;
  //   return user!.email;
  // }

  @override
  List<Object> get props => [user!, i];
}
