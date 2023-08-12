import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> LikePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postComment(String postId, String uid, String text, String name,
      String profilPic) async {
    try {
      String commentId = Uuid().v1();
      if (text.isNotEmpty) {
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilPic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now()
        });
      }
    } catch (e) {}
  }

  Future<void> deletePost(String postid) async {
    try {
      await _firestore.collection('posts').doc(postid).delete();
    } catch (e) {}
  }

  Future<void> follow(String uid, String followId) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    List followings = (snapshot.data()! as dynamic)['followings'];

    if (followings.contains(followId)) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(followId)
          .update({
        'followers': FieldValue.arrayRemove([uid])
      });
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'followings': FieldValue.arrayRemove([followId])
      });
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(followId)
          .update({
        'followers': FieldValue.arrayUnion([uid])
      });
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'followings': FieldValue.arrayUnion([followId])
      });
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
