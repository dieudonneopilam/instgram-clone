import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _store = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //upload fil
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool ispost) async {
    Reference ref = _store.ref().child(childName).child(_auth.currentUser!.uid);
    if (ispost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;

    String download = await snap.ref.getDownloadURL();
    return download;
  }
}
