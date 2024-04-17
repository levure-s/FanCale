import 'package:fancale/register/register_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterFrom extends StatelessWidget {
  const RegisterFrom({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<RegisterModel>();

    return Stack(
      children: [
        Padding(
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
                  obscureText: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: () async {
                      bool isCreated = true;

                      model.startLoading();

                      try {
                        await model.signUp();
                        isCreated = true;
                      } catch (e) {
                        final snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(e.toString()));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } finally {
                        model.endLoading();
                        if (isCreated) {
                          Navigator.of(context).pop();
                        }
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
  }
}
