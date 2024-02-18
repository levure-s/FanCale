import 'package:fancale/add_calender_memo/add_calender_memo_page.dart';
import 'package:fancale/calender/calender_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Calender>();

    return IconButton(
        onPressed: () async {
          try {
            await showDialog<String>(
                context: context,
                builder: (context) =>
                    AddClenderMemo(selectedDay: model.selectedDay));
          } catch (e) {
            print('エラー：$e');
          }
        },
        icon: const Icon(Icons.add));
    ;
  }
}
