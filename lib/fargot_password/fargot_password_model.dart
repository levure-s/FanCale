import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FargotPasswordModel extends ChangeNotifier {
  final emailController = TextEditingController();

  String? email;
  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  Future sendEmail() async {
    email = emailController.text;

    if (email == '') {
      throw ('メールアドレスを入力してください');
    }

    await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
  }
}
