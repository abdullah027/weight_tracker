import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:weight_tracker/Models/user_model.dart';

class UserProvider extends ChangeNotifier {
  Users? _user;

  Users? get user => _user;

  void setUser(Users? user) {
    _user = user;
    notifyListeners();
  }

  void restUserProvider() {
    _user = null;
    notifyListeners();
  }
}
