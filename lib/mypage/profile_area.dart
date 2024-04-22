import 'package:fancale/mypage/my_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileArea extends StatelessWidget {
  const ProfileArea({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MyModel>();

    if (model.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            model.name ?? '名前なし',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(model.email ?? 'メールアドレスなし'),
          Text(model.description ?? '自己紹介なし'),
          TextButton(
              onPressed: () async {
                bool isSuccess = false;
                try {
                  await model.logout();
                  isSuccess = true;
                } finally {
                  if (isSuccess) {
                    Navigator.of(context).pop();
                  }
                }
              },
              child: const Text('ログアウト'))
        ],
      ),
    );
  }
}
