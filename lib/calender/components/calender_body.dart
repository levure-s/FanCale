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
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    return ChangeNotifierProvider(
      create: (_) => Graphics(currentMonth: month)..fetchGraphics(),
      child: isTablet
          ? Row(
              children: [
                Expanded(
                  child: GraphicArea(
                    isTablet: isTablet,
                  ),
                ),
                Expanded(
                    child: Column(
                  children: const [CalenderArea(), MemoArea()],
                ))
              ],
            )
          : Column(
              children: [
                GraphicArea(
                  isTablet: isTablet,
                ),
                const CalenderArea(),
                const MemoArea()
              ],
            ),
    );
  }
}
