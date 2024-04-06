import 'package:fancale/edit_calender_graphics/edit_calender_graphics_model.dart';
import 'package:fancale/edit_calender_graphics/select_graphic_area.dart';
import 'package:fancale/login/login_model.dart';
import 'package:fancale/register/register_model.dart';
import 'package:fancale/register/register_page.dart';
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
          body: Center(
            child: Consumer<LoginModel>(
              builder: (context, model, child) {
                return Stack(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: model.titleController,
                              decoration:
                                  const InputDecoration(hintText: 'Email'),
                              onChanged: (text) {
                                model.setEmail(text);
                              },
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextField(
                              controller: model.autherController,
                              decoration:
                                  const InputDecoration(hintText: 'パスワード'),
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
                                    Navigator.of(context).pop();
                                  } catch (e) {
                                    final snackBar = SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(e.toString()));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } finally {
                                    model.endLoading();
                                  }
                                },
                                child: const Text('ログイン')),
                            TextButton(
                                onPressed: () async {
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RegisterPage(),
                                          fullscreenDialog: true));
                                },
                                child: const Text('新規登録の方はこちら'))
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
              },
            ),
          ),
        ));
  }
}
