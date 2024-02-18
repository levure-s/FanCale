import 'package:fancale/calender/add_button.dart';
import 'package:fancale/calender/calender_body.dart';
import 'package:fancale/calender/calender_model.dart';
import 'package:fancale/calender/model_area.dart';
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
