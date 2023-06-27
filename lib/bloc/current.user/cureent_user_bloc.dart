import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gde/models/user.dart';
import 'package:gde/resources/auth_method.dart';

part 'cureent_user_event.dart';
part 'cureent_user_state.dart';

class CureentUserBloc extends Bloc<CureentUserEvent, CureentUserState> {
  final AuthMethods authMethod;
  CureentUserBloc({required this.authMethod})
      : super(CureentUserInitial(
            userModel: UserModel(
                email: 'dd',
                uid: '',
                photoUrl: '',
                followers: [],
                following: []),
            etat: RequestEtat.none)) {
    on<CureentUserEvent>((event, emit) async {
      try {
        UserModel data = await authMethod.getUserDetails();
        print(data.email);
        emit(CureentUserInitial(userModel: data, etat: RequestEtat.exist));
      } catch (e) {
        print('failed opilam');
      }
    });
  }
}
