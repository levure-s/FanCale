import 'package:fancale/fargot_password/fargot_password_form.dart';
import 'package:fancale/fargot_password/fargot_password_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FargotPasswordPage extends StatelessWidget {
  const FargotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => FargotPasswordModel(),
        child: Scaffold(
          appBar: AppBar(title: const Text('パスワードリセット')),
          body: const Center(
            child: FargotPasswordForm(),
          ),
        ));
  }
}
