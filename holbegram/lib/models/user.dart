import 'package:cloud_firestore/cloud_firestore.dart';

class Userd {
  final String uid;
  final String email;
  final String username;
  final String bio;
  final String photoUrl;
  final List<dynamic> followers;
  final List<dynamic> following;
  final List<dynamic> posts;
  final List<dynamic> saved;
  final String searchKey;

  Userd({
    required this.uid,
    required this.email,
    required this.username,
    required this.bio,
    required this.photoUrl,
    required this.followers,
    required this.following,
    required this.posts,
    required this.saved,
    required this.searchKey,
  });

  static Userd fromSnap(DocumentSnapshot snap) {
    var data = snap.data() as Map<String, dynamic>;
    return Userd(
      uid: data['uid'],
      email: data['email'],
      username: data['username'],
      bio: data['bio'],
      photoUrl: data['photoUrl'],
      followers: data['followers'],
      following: data['following'],
      posts: data['posts'],
      saved: data['saved'],
      searchKey: data['searchKey'],
    );
  }

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "email": email,
    "username": username,
    "bio": bio,
    "photoUrl": photoUrl,
    "followers": followers,
    "following": following,
    "posts": posts,
    "saved": saved,
    "searchKey": searchKey,
  };
}
