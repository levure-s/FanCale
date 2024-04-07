import 'package:fancale/edit_profile/edit_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage(this.name, this.description, {super.key});
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => EditProfileModel(name, description),
        child: Scaffold(
          appBar: AppBar(title: const Text('プロフィール編集')),
          body: Center(
            child: Consumer<EditProfileModel>(
              builder: (context, model, child) {
                return Stack(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: model.nameController,
                              decoration: const InputDecoration(hintText: '名前'),
                              onChanged: (text) {
                                model.setName(text);
                              },
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextField(
                              controller: model.descriptionController,
                              decoration:
                                  const InputDecoration(hintText: '自己紹介'),
                              onChanged: (text) {
                                model.setDescription(text);
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  model.startLoading();
                                  try {
                                    await model.update();
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
                                child: const Text('更新する')),
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
