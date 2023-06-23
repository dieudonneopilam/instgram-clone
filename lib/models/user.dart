import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String uid;
  final String photoUrl;
  final List followers;
  final List following;

  const UserModel(
      {required this.email,
      required this.uid,
      required this.photoUrl,
      required this.followers,
      required this.following});

  Map<String, dynamic> toJson() => {
        'email': email,
        'uid': uid,
        'photoUrl': photoUrl,
        'followers': followers,
        'following': following
      };
  // static UserModel fromSnap(DocumentSnapshot snap) {
  //   var snapshot = snap.data() as Map<String, dynamic>;
  //   return UserModel(
  //       email: snapshot['email'],
  //       uid: snapshot['uid'],
  //       photoUrl: snapshot['photoUrl'],
  //       followers: snapshot['followers'],
  //       following: snapshot['following']);
  // }
}
