import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gde/models/user.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  final FirebaseAuth auth;
  CurrentUserBloc({required this.auth})
      : super(CurrentUserInitial(
            user: UserModel(
                email: '',
                uid: '',
                photoUrl: '',
                followers: [],
                followings: [],
                bio: '',
                username: ''))) {
    on<OnChanged>((event, emit) async {
      try {
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get();
        emit(CurrentUserInitial(user: UserModel.fromSnap(documentSnapshot)));
      } catch (e) {}
    });
  }
}
