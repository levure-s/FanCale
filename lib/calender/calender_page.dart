import 'package:fancale/calender/graphic_area.dart';
import 'package:fancale/calender/memo_area.dart';
import 'package:fancale/calender/add_button.dart';
import 'package:fancale/calender/calender_body.dart';
import 'package:fancale/calender/calender_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalenderPage extends StatelessWidget {
  const CalenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Calender()..fetchCalender(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('カレンダー'),
          actions: const [AddButton()],
        ),
        body: Column(
          children: const [GraphicArea(), CalenderBody(), MemoArea()],
        ),
      ),
    );
  }
}
