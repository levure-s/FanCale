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
          body: Center(
            child: Consumer<RegisterModel>(
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
                                    await model.signUp();
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
                                child: const Text('登録する'))
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
