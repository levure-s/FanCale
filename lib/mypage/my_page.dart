import 'package:fancale/mypage/edit_button.dart';
import 'package:fancale/mypage/my_model.dart';
import 'package:fancale/mypage/profile_area.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MyModel()..feachUser(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('マイページ'),
            actions: const [EditButton()],
          ),
          body: const Center(child: ProfileArea()),
        ));
  }
}
