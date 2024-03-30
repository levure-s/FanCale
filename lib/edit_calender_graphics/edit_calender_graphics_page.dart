import 'package:fancale/edit_calender_graphics/edit_calender_graphics_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditCalenderGraphics extends StatelessWidget {
  const EditCalenderGraphics({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => EditCalenderGraphicsModel(),
        child: Scaffold(
          appBar: AppBar(title: const Text('月ごとの画像を選択')),
          body: Center(child: Consumer<EditCalenderGraphicsModel>(
              builder: (context, model, child) {
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
                            ? Image.file(model.imageFile!)
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
                          try {
                            model.startLoading();
                            await model.saveImage();
                          } finally {
                            model.endLoading();
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
          })),
        ));
  }
}
