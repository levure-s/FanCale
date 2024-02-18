import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancale/calender/calender_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
