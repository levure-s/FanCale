import 'package:fancale/login/login_form.dart';
import 'package:fancale/login/login_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginModel(),
      child: Scaffold(
        appBar: AppBar(title: const Text('ログイン')),
        body: const Center(child: LoginForm()),
      ),
    );
  }
}
