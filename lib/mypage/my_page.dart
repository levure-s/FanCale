import 'package:fancale/edit_calender_graphics/edit_calender_graphics_model.dart';
import 'package:fancale/edit_calender_graphics/select_graphic_area.dart';
import 'package:fancale/login/login_model.dart';
import 'package:fancale/mypage/my_model.dart';
import 'package:fancale/register/register_model.dart';
import 'package:fancale/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MyModel()..feachUser(),
        child: Scaffold(
          appBar: AppBar(title: const Text('マイページ')),
          body: Center(
            child: Consumer<MyModel>(
              builder: (context, model, child) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            '名前',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(model.email ?? 'メールアドレスなし'),
                          Text('自己紹介')
                        ],
                      ),
                    ),
                    if (model.isLoading)
                      Container(
                          color: Colors.black54,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ))
                  ],
                );
              },
            ),
          ),
        ));
  }
}
