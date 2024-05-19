import 'package:fancale/calender/model/calender_model.dart';
import 'package:fancale/calender/model/graphics_model.dart';
import 'package:fancale/home/home_model.dart';
import 'package:fancale/login/login_page.dart';
import 'package:fancale/mypage/my_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MypageButton extends StatelessWidget {
  const MypageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final home = context.watch<HomeModel>();
    final calender = context.watch<Calender>();
    // final graphics = context.watch<Graphics>();
    return IconButton(
        onPressed: () async {
          if (FirebaseAuth.instance.currentUser != null) {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyPage(),
                    fullscreenDialog: true));
            calender.readyForLogout();
            home.readyForLogout();
            home.logout();
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
