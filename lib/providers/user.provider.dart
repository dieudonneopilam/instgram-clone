// import 'package:flutter/foundation.dart';
// import 'package:gde/models/user.dart';
// import 'package:gde/resources/auth_method.dart';

// class userProvider extends ChangeNotifier {
//   User? _user;
//   final AuthMethods _authMethods = AuthMethods();
//   User get getUser => _user!;

//   Future<void> refreshUser() async {
//     User user = await _authMethods.getUserDetatils();
//     _user = user;
//     notifyListeners();
//   }
// }
