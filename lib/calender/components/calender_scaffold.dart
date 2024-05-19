import 'package:fancale/calender/components/add_button.dart';
import 'package:fancale/calender/components/calender_area.dart';
import 'package:fancale/calender/components/calender_body.dart';
import 'package:fancale/calender/components/graphic_area.dart';
import 'package:fancale/calender/components/memo_area.dart';
import 'package:fancale/calender/components/mypage_button.dart';
import 'package:fancale/calender/model/calender_model.dart';
import 'package:fancale/calender/model/graphics_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class CalenderScaffold extends StatelessWidget {
  const CalenderScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Calender>();
    final month = model.focusedDay.month;

    return ChangeNotifierProvider(
      create: (_) => Graphics(currentMonth: month)..fetchGraphics(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('カレンダー'),
          actions: const [AddButton(), MypageButton()],
        ),
        body: Column(
          children: const [GraphicArea(), CalenderArea(), MemoArea()],
        ),
      ),
    );
  }
}
