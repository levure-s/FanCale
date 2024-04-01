import 'package:fancale/edit_calender_graphics/edit_calender_graphics_model.dart';
import 'package:fancale/edit_calender_graphics/select_graphic_area.dart';
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
          body: const Center(child: SelectGraphicArea()),
        ));
  }
}
