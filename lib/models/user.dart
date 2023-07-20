import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String uid;
  final String photoUrl;
  final List followers;
  final List followings;
  final String bio;
  final String username;

  const UserModel({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.followers,
    required this.followings,
    required this.bio,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'uid': uid,
        'photoUrl': photoUrl,
      };
  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      email: snapshot['email'],
      uid: snapshot['uid'],
      photoUrl: snapshot['photoUrl'],
      bio: snapshot['bio'],
      followers: snapshot['followers'],
      followings: snapshot['followings'],
      username: snap['username'],
    );
  }
}
