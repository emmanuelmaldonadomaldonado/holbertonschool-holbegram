import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';
import '../screens/auth/methods/user_storage.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return "Please fill all the fields";
    }

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "success";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    Uint8List? file,
  }) async {
    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      return "Please fill all the fields";
    }

    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String photoUrl =
          file != null
              ? await StorageMethods().uploadImageToStorage(
                false,
                "profilePics",
                file,
              )
              : "";

      Userd user = Userd(
        uid: cred.user!.uid,
        email: email,
        username: username,
        bio: "",
        photoUrl: photoUrl,
        followers: [],
        following: [],
        posts: [],
        saved: [],
        searchKey: username.toLowerCase(),
      );

      await _firestore.collection("users").doc(user.uid).set(user.toJson());

      return "success";
    } catch (e) {
      return e.toString();
    }
  }
}
