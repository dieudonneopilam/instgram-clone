import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gde/models/user.dart';

part 'cureent_user_event.dart';
part 'cureent_user_state.dart';

class CureentUserBloc extends Bloc<CureentUserEvent, CureentUserState> {
  CureentUserBloc() : super(CureentUserInitial()) {
    on<CureentUserEvent>((event, emit) {});
  }
}
