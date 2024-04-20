import 'package:fancale/calender/model/calender_model.dart';
import 'package:fancale/calender/model/graphics_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderArea extends StatelessWidget {
  const CalenderArea({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Calender>();
    final graphics = context.watch<Graphics>();

    return TableCalendar(
      locale: 'ja_JP',
      firstDay: DateTime.utc(1997, 8, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: model.focusedDay,
      calendarFormat: model.calendarFormat,
      onFormatChanged: (format) {
        model.changeFormat(format);
      },
      selectedDayPredicate: (day) => isSameDay(model.selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        model.changedDay(selectedDay, focusedDay);
      },
      onPageChanged: (focusedDay) {
        model.changePage(focusedDay);
        graphics.changeCurrentMonth(focusedDay.month);
      },
    );
  }
}
