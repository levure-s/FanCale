import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeModel extends ChangeNotifier {
  bool isLogin = false;

  void checkLoginInfo() {
    isLogin = FirebaseAuth.instance.currentUser != null;
    notifyListeners();
  }
}
