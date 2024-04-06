import 'package:fancale/calender/components/graphic_area.dart';
import 'package:fancale/calender/components/memo_area.dart';
import 'package:fancale/calender/components/add_button.dart';
import 'package:fancale/calender/components/calender_body.dart';
import 'package:fancale/calender/model/calender_model.dart';
import 'package:fancale/login/login_page.dart';
import 'package:fancale/mypage/my_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalenderPage extends StatelessWidget {
  const CalenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Calender()..fetchCalender(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('カレンダー'),
          actions: [
            AddButton(),
            IconButton(
                onPressed: () async {
                  if (FirebaseAuth.instance.currentUser != null) {
                    print('ログインしている');
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyPage(),
                            fullscreenDialog: true));
                  } else {
                    print('ログインしていない');
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage(),
                            fullscreenDialog: true));
                  }
                },
                icon: Icon(Icons.person))
          ],
        ),
        body: Column(
          children: const [GraphicArea(), CalenderBody(), MemoArea()],
        ),
      ),
    );
  }
}
