import 'package:fancale/calender/components/calender_area.dart';
import 'package:fancale/calender/components/graphic_area.dart';
import 'package:fancale/calender/components/memo_area.dart';
import 'package:fancale/calender/model/calender_model.dart';
import 'package:fancale/calender/model/graphics_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalenderBody extends StatelessWidget {
  const CalenderBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Calender>();
    final month = model.focusedDay.month;

    return ChangeNotifierProvider(
      create: (_) => Graphics(currentMonth: month)..fetchGraphics(),
      child: Column(
        children: const [GraphicArea(), CalenderArea(), MemoArea()],
      ),
    );
  }
}
