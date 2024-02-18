import 'package:fancale/calender/calender_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderBody extends StatelessWidget {
  const CalenderBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Calender>();

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
    );
  }
}
