import 'package:fancale/calender/components/graphic.dart';
import 'package:fancale/calender/model/graphics_model.dart';
import 'package:fancale/edit_calender_graphics/edit_calender_graphics_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GraphicArea extends StatelessWidget {
  const GraphicArea({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Graphics()..fetchGraphics(),
      child: const SizedBox(
        width: double.infinity,
        height: 150,
        child: Graphic(),
      ),
    );
  }
}
