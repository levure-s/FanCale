import 'package:fancale/add_calender_memo/add_calender_memo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddClenderMemo extends StatelessWidget {
  final DateTime? selectedDay;
  const AddClenderMemo({super.key, required this.selectedDay});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) => AddClenderMemoModel(),
      child: AlertDialog(
        title: const Text('メモを入力してください'),
        content: TextField(controller: controller),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('キャンセル')),
          Consumer<AddClenderMemoModel>(builder: (context, model, child) {
            return TextButton(
                onPressed: () async {
                  try {
                    await model.addMemo(selectedDay, controller.text);
                  } catch (e) {
                    final snackBar = SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(e.toString()));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  Navigator.pop(context);
                },
                child: const Text('OK'));
          })
        ],
      ),
    );
    ;
  }
}
