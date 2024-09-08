import 'package:fancale/edit_profile/edit_profile_model.dart';
import 'package:fancale/home/home_model.dart';
import 'package:fast_color_picker/fast_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditForm extends StatelessWidget {
  const EditForm({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<EditProfileModel>();
    final home = context.watch<HomeModel>();

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
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('イメージカラー'),
                ),
                FittedBox(
                  child: FastColorPicker(
                      selectedColor: model.color,
                      onColorSelected: (color) {
                        model.setColor(color);
                        home.setColor(color);
                      }),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: () async {
                      bool isUpdated = false;

                      model.startLoading();
                      try {
                        await model.update();
                        isUpdated = true;
                      } catch (e) {
                        final snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(e.toString()));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } finally {
                        model.endLoading();
                        if (isUpdated) {
                          home.featchColor();
                          Navigator.of(context).pop();
                        }
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
  }
}
