import 'package:fancale/fargot_password/fargot_password_page.dart';
import 'package:fancale/home/home_model.dart';
import 'package:fancale/login/login_model.dart';
import 'package:fancale/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<LoginModel>();
    final home = context.watch<HomeModel>();

    return Stack(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: model.emailController,
                  decoration: const InputDecoration(hintText: 'Email'),
                  onChanged: (text) {
                    model.setEmail(text);
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: model.passwordController,
                  decoration: const InputDecoration(hintText: 'パスワード'),
                  onChanged: (text) {
                    model.setPaaword(text);
                  },
                  obscureText: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: () async {
                      model.startLoading();
                      try {
                        await model.login();
                        home.checkLoginInfo();
                      } catch (e) {
                        final msg = model.convertErrorMessage(e.toString());
                        final snackBar = SnackBar(
                            backgroundColor: Colors.red, content: Text(msg));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } finally {
                        model.endLoading();
                      }
                    },
                    child: const Text('ログイン')),
                const SizedBox(
                  height: 16,
                ),
                TextButton(
                    onPressed: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                              fullscreenDialog: true));
                    },
                    child: const Text('新規登録の方はこちら')),
                TextButton(
                    onPressed: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FargotPasswordPage(),
                              fullscreenDialog: true));
                    },
                    child: const Text('パスワードを忘れた'))
              ],
            )),
        if (model.isLoading)
          Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ))
      ],
    );
  }
}
