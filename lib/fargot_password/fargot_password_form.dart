import 'package:fancale/fargot_password/fargot_password_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FargotPasswordForm extends StatelessWidget {
  const FargotPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<FargotPasswordModel>();

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
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: () async {
                      bool isSuccess = false;

                      model.startLoading();

                      try {
                        await model.sendEmail();
                        isSuccess = true;
                      } catch (e) {
                        final msg = model.convertErrorMessage(e.toString());
                        final snackBar = SnackBar(
                            backgroundColor: Colors.red, content: Text(msg));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } finally {
                        model.endLoading();
                        if (isSuccess) {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    child: const Text('メールを送信')),
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
