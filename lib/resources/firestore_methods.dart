import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gde/models/post.dart';
import 'package:gde/resources/storqge_method.dart';
import 'package:uuid/uuid.dart';

class FirestoreMedthods {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //upload post
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profilImage) async {
    String res = 'some error';
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();
      PostModel postModel = PostModel(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profilImage: profilImage,
        likes: [],
      );
      _firestore.collection('posts').doc(postId).set(postModel.toJson());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(uid).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(uid).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {}
  }
}
