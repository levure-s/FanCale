import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeModel extends ChangeNotifier {
  bool isLogin = false;
  MaterialColor color = Colors.blue;

  void initialize() {
    checkLoginInfo();
    featchColor();
  }

  void checkLoginInfo() {
    isLogin = FirebaseAuth.instance.currentUser != null;
    notifyListeners();
  }

  void initializeColor() {
    color = Colors.blue;
    notifyListeners();
  }

  void setColor(Color newcolor) {
    color = _createMaterialColor(newcolor);
    notifyListeners();
  }

  Future featchColor() async {
    if (FirebaseAuth.instance.currentUser == null) {
      initializeColor();
      return;
    }

    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = snapshot.data();

    if (data == null || data['color'] == null) {
      initializeColor();
      return;
    }

    int colorNum = data['color'];
    color = _createMaterialColor(Color(colorNum));
    notifyListeners();
  }

  MaterialColor _createMaterialColor(Color color) {
    //渡されたカラーを分解
    final r = color.red;
    final g = color.green;
    final b = color.blue;

    //カラーの濃さのベースをなるリストを作成
    final strengths = <double>[.05];
    final swatch = <int, Color>{};
    for (var i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    //50~900のカラーパレット(Map)を作成
    for (final strength in strengths) {
      final ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
