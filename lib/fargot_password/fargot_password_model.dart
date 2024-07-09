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

  String convertErrorMessage(String msg) {
    if (msg.contains('[firebase_auth/invalid-email]')) {
      return 'メールアドレスを正しい形式で入力してください';
    }
    return msg;
  }

  Future sendEmail() async {
    email = emailController.text;

    if (email == '') {
      throw ('メールアドレスを入力してください');
    }

    await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
  }
}
