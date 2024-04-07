import 'package:fancale/edit_profile/edit_profile_page.dart';
import 'package:fancale/mypage/my_model.dart';
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
            actions: [
              Consumer<MyModel>(builder: (context, model, child) {
                return IconButton(
                    onPressed: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfilePage(
                                  model.name ?? '', model.description ?? '')));
                      model.feachUser();
                    },
                    icon: const Icon(Icons.edit));
              })
            ],
          ),
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
                            model.name ?? '名前なし',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(model.email ?? 'メールアドレスなし'),
                          Text(model.description ?? '自己紹介なし'),
                          TextButton(
                              onPressed: () async {
                                await model.logout();
                                Navigator.of(context).pop();
                              },
                              child: const Text('ログアウト'))
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
