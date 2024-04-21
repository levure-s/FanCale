import 'package:fancale/add_calender_graphics/add_calender_graphics_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectGraphicArea extends StatelessWidget {
  const SelectGraphicArea({super.key, required this.month});
  final int month;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AddCalenderGraphicsModel>();

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            GestureDetector(
              child: SizedBox(
                width: double.infinity,
                height: 150,
                child: model.imageFile != null
                    ? Image.file(
                        model.imageFile!,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: Colors.grey,
                      ),
              ),
              onTap: () async {
                await model.pickImage();
              },
            ),
            ElevatedButton(
                onPressed: () async {
                  bool isSuccess = false;

                  try {
                    model.startLoading();
                    await model.saveImage(month);
                    isSuccess = true;
                  } catch (e) {
                    final snackBar = SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(e.toString()));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } finally {
                    model.endLoading();
                    if (isSuccess) {
                      Navigator.of(context).pop(true);
                    }
                  }
                },
                child: const Text('保存する'))
          ]),
        ),
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
