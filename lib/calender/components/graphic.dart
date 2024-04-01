import 'package:fancale/calender/model/graphics_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Graphic extends StatelessWidget {
  const Graphic({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Graphics>();

    if (model.graphicURL == '') {
      return Container(
        color: Colors.grey,
      );
    }
    return Image.network(
      model.graphicURL,
      fit: BoxFit.cover,
    );
  }
}
