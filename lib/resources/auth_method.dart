// import 'dart:ffi';
// ignore_for_file: unnecessary_null_comparison

import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gde/resources/storqge_method.dart';

import '../models/user.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return UserModel.fromSnap(snapshot);
  }

  Future<void> signUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // return 'success';
    } catch (e) {
      // return e.toString();
    }
  }

  //signup user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "some error";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty) {
        //registrer user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilPics', file, false);
        //add user to our databse
        _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'followings': [],
          'photoUrl': photoUrl
        });

        res = "success";
      } else {
        await Future.delayed(Duration(seconds: 5));
        res = 'complete all fields';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //login user
  Future<String> loginUser(String email, String password) async {
    String res = 'some error';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'complete all fields';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> sign_up(String email, String password, String username,
      String bio, Uint8List file) async {
    String res = 'some error';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      } else {
        res = 'complete all fields';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
