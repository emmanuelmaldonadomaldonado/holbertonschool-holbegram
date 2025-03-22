import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:holbegram/models/user.dart' as model;
import 'package:holbegram/screens/auth/methods/user_storage.dart';

class AuthMethode {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 🔐 Login Method
  Future<String> login({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please fill all the fields";
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  // 📝 Sign Up Method
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    Uint8List? file,
  }) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoUrl = await StorageMethods().uploadImageToStorage(
          false,
          'profilePics',
          file,
        );

        model.Userd user = model.Userd(
          uid: cred.user!.uid,
          email: email,
          username: username,
          bio: '',
          photoUrl: photoUrl,
          followers: [],
          following: [],
          posts: [],
          saved: [],
          searchKey: username.toLowerCase(),
        );

        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = "success";
      } else {
        res = "Please fill all the fields";
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  // 👤 Get current user details
  Future<model.Userd> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection("users").doc(currentUser.uid).get();

    return model.Userd.fromSnap(snap);
  }

  // 🚪 Logout method
  Future<void> logout() async {
    await _auth.signOut();
  }
}
