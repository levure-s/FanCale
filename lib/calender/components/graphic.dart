import 'package:fancale/calender/model/graphics_model.dart';
import 'package:fancale/edit_calender_graphics/edit_calender_graphics_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Graphic extends StatelessWidget {
  const Graphic({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Graphics>();
    void showSnackBar() {
      const snackBar =
          SnackBar(backgroundColor: Colors.green, content: Text('画像を変更しました'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return GestureDetector(
      onTap: () async {
        final bool? isEdited = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    EditCalenderGraphics(month: model.currentMonth),
                fullscreenDialog: true));

        if (isEdited != null && isEdited) {
          showSnackBar();
        }

        model.fetchGraphics();
      },
      child: model.graphicURL == ''
          ? Container(
              color: Colors.grey,
            )
          : Image.network(
              model.graphicURL,
              fit: BoxFit.cover,
            ),
    );
  }
}
