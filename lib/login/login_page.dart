import 'package:fancale/edit_calender_graphics/edit_calender_graphics_model.dart';
import 'package:fancale/edit_calender_graphics/select_graphic_area.dart';
import 'package:fancale/register/register_model.dart';
import 'package:fancale/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => RegisterModel(),
        child: Scaffold(
          appBar: AppBar(title: const Text('ログイン')),
          body: Center(
            child: Consumer<RegisterModel>(
              builder: (context, model, child) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: model.titleController,
                          decoration: const InputDecoration(hintText: 'Email'),
                          onChanged: (text) {
                            model.setEmail(text);
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: model.autherController,
                          decoration: const InputDecoration(hintText: 'パスワード'),
                          onChanged: (text) {
                            model.setPaaword(text);
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              try {
                                await model.signUp();
                                // Navigator.of(context).pop(model.email);
                              } catch (e) {
                                final snackBar = SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(e.toString()));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
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
                    ));
              },
            ),
          ),
        ));
  }
}
