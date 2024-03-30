import 'package:fancale/calender/graphics_model.dart';
import 'package:fancale/edit_calender_graphics/edit_calender_graphics_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GraphicArea extends StatelessWidget {
  const GraphicArea({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Graphics()..fetchGraphics(),
      child: SizedBox(
        width: double.infinity,
        height: 150,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditCalenderGraphics(),
                    fullscreenDialog: true));
          },
          child: Consumer<Graphics>(builder: (context, model, child) {
            if (model.graphicURL == '') {
              return SizedBox(
                width: double.infinity,
                height: 150,
                child: Container(
                  color: Colors.grey,
                ),
              );
            }
            return Image.network(
              model.graphicURL,
              fit: BoxFit.cover,
            );
          }),
        ),
      ),
    );
  }
}
