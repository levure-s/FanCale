import 'package:fancale/calender/model/graphic.dart';
import 'package:fancale/edit_calender_graphics/edit_calender_graphics_model.dart';
import 'package:fancale/edit_calender_graphics/select_graphic_area.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditCalenderGraphics extends StatelessWidget {
  const EditCalenderGraphics({super.key, required this.graphic});
  final Graphic graphic;

  @override
  Widget build(BuildContext context) {
    final int month = graphic.month;
    return ChangeNotifierProvider(
        create: (_) => EditCalenderGraphicsModel(graphic: graphic),
        child: Scaffold(
          appBar: AppBar(title: Text('$month月の画像を選択')),
          body: const Center(child: SelectGraphicArea()),
        ));
  }
}
