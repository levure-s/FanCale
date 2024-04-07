import 'package:fancale/login/login_page.dart';
import 'package:fancale/mypage/my_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MypageButton extends StatelessWidget {
  const MypageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          if (FirebaseAuth.instance.currentUser != null) {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyPage(),
                    fullscreenDialog: true));
          } else {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                    fullscreenDialog: true));
          }
        },
        icon: const Icon(Icons.person));
  }
}
