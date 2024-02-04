import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('カレンダー'),
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  await showDialog<String>(
                      context: context,
                      builder: (context) {
                        final TextEditingController controller =
                            TextEditingController();
                        return AlertDialog(
                          title: const Text('メモを入力してください'),
                          content: TextField(controller: controller),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('キャンセル')),
                            TextButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('calendar')
                                      .add({
                                    'date': Timestamp.fromDate(_selectedDay!),
                                    'memo': controller.text
                                  });
                                  if (mounted) {
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text('OK'))
                          ],
                        );
                      });
                } catch (e) {
                  print('エラー：$e');
                }
              },
              icon: const Icon(Icons.add))
        ],
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
          TableCalendar(
            locale: 'ja_JP',
            firstDay: DateTime.utc(1997, 8, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              _focusedDay = focusedDay;
              _selectedDay = selectedDay;
              setState(() {});
            },
          ),
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('calendar').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<QueryDocumentSnapshot> documents =
                      snapshot.data!.docs;

                  final List<QueryDocumentSnapshot> filteredDocuments =
                      documents.where((doc) {
                    final date = (doc['date'] as Timestamp).toDate();
                    return isSameDay(_selectedDay, date);
                  }).toList();

                  filteredDocuments
                      .sort((a, b) => a['date'].compareTo(b['date']));
                  return Expanded(
                      child: ListView.builder(
                          itemCount: filteredDocuments.length,
                          itemBuilder: (context, index) {
                            final document = filteredDocuments[index];
                            final date =
                                (document['date'] as Timestamp).toDate();
                            return ListTile(
                              trailing: IconButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('calendar')
                                      .doc(document.id)
                                      .delete();
                                },
                                icon: const Icon(Icons.delete),
                              ),
                              title: Text(document['memo']),
                              subtitle: Text(
                                  '${date.year}/${date.month}/${date.day}'),
                            );
                          }));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })
        ],
      ),
    );
  }
}
