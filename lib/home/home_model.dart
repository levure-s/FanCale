import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeModel extends ChangeNotifier {
  bool isLogin = false;
  bool isWaitng = false;

  void readyForLogout() {
    isWaitng = true;
    notifyListeners();
  }

  void checkLoginInfo() {
    if (isWaitng) {
      isWaitng = false;
    }
    isLogin = FirebaseAuth.instance.currentUser != null;
    notifyListeners();
  }
}
