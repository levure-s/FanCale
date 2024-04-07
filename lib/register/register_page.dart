import 'package:fancale/register/register_form.dart';
import 'package:fancale/register/register_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => RegisterModel(),
        child: Scaffold(
          appBar: AppBar(title: const Text('新規登録')),
          body: const Center(
            child: RegisterFrom(),
          ),
        ));
  }
}
