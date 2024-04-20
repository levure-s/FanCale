import 'package:fancale/calender/components/graphic.dart';
import 'package:fancale/calender/model/graphics_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GraphicArea extends StatelessWidget {
  const GraphicArea({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: 150,
      child: Graphic(),
    );
  }
}
