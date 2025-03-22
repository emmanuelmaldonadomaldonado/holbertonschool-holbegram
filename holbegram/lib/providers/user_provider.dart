import 'package:flutter/material.dart';
import '../models/user.dart';
import '../methods/auth_methods.dart';

class UserProvider with ChangeNotifier {
  Userd? _user;
  final AuthMethode _authMethode = AuthMethode();

  Userd get getUser => _user!;

  Future<void> refreshUser() async {
    Userd user = await _authMethode.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
