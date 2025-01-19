import 'package:fancale/edit_calender_graphics/edit_calender_graphics_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectGraphicArea extends StatelessWidget {
  const SelectGraphicArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<EditCalenderGraphicsModel>();
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: isTablet
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: _buildImageSection(context, model, isTablet)),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSlider(model, isTablet),
                        _buildSaveButton(context, model),
                      ],
                    ))
                  ],
                )
              : Column(children: [
                  _buildImageSection(context, model, isTablet),
                  _buildSlider(model, isTablet),
                  _buildSaveButton(context, model)
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

  Widget _buildImageSection(
      BuildContext context, EditCalenderGraphicsModel model, bool isTablet) {
    return GestureDetector(
      child: SizedBox(
        width: double.infinity,
        height: isTablet ? double.infinity : 150,
        child: model.imageFile != null
            ? Image.file(
                model.imageFile!,
                fit: BoxFit.cover,
                alignment:
                    Alignment(model.imageAlignmentX, model.imageAlignmentY),
              )
            : Image.network(
                model.graphic.imgURL,
                fit: BoxFit.cover,
                alignment:
                    Alignment(model.imageAlignmentX, model.imageAlignmentY),
              ),
      ),
      onTap: () async {
        await model.pickImage();
      },
    );
  }

  Widget _buildSlider(EditCalenderGraphicsModel model, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isTablet ? const SizedBox() : const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 24.0),
          child: Text(
            '位置調整',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Slider(
          min: -1.0,
          max: 1.0,
          value: isTablet ? model.imageAlignmentX : model.imageAlignmentY,
          onChanged: (newValue) {
            if (isTablet) {
              model.updateAlignmentX(newValue);
            } else {
              model.updateAlignmentY(newValue);
            }
          },
        ),
      ],
    );
  }

  Widget _buildSaveButton(
      BuildContext context, EditCalenderGraphicsModel model) {
    return Center(
      child: SizedBox(
          width: 150,
          child: ElevatedButton(
              onPressed: () async {
                bool isSuccess = false;

                try {
                  model.startLoading();
                  await model.saveImage();
                  isSuccess = true;
                } catch (e) {
                  final snackBar = SnackBar(
                      backgroundColor: Colors.red, content: Text(e.toString()));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } finally {
                  model.endLoading();
                  if (isSuccess) {
                    Navigator.of(context).pop(true);
                  }
                }
              },
              child: const Text('保存する'))),
    );
  }
}
