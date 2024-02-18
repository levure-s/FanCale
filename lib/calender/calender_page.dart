import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancale/add_calender_memo/add_calender_memo_page.dart';
import 'package:fancale/calender/calender_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

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
          children: [
            SizedBox(
              width: double.infinity,
              height: 150,
              child: Image.network(
                'https://bitfan-id.s3.ap-northeast-1.amazonaws.com/store/6cc3e1d10c295340c9531eeb256e332b.jpg',
                fit: BoxFit.cover,
              ),
            ),
            const CalenderBody(),
            const MemoArea()
          ],
        ),
      ),
    );
  }
}

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

class MemoArea extends StatelessWidget {
  const MemoArea({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Calender>();

    final List<QueryDocumentSnapshot>? filteredDocuments =
        model.filteredDocuments;

    if (filteredDocuments == null) {
      return const CircularProgressIndicator();
    }

    return Expanded(
        child: ListView.builder(
            itemCount: filteredDocuments.length,
            itemBuilder: (context, index) {
              final document = filteredDocuments[index];
              final date = (document['date'] as Timestamp).toDate();
              return ListTile(
                trailing: IconButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('calendar')
                        .doc(document.id)
                        .delete();
                    model.fetchCalender();
                  },
                  icon: const Icon(Icons.delete),
                ),
                title: Text(document['memo']),
                subtitle: Text('${date.year}/${date.month}/${date.day}'),
              );
            }));
  }
}
