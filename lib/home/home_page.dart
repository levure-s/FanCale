import 'package:fancale/calender/calender_page.dart';
import 'package:fancale/home/home_model.dart';
import 'package:fancale/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeModel>();

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: model.color,
        ),
        home: model.isLogin ? const CalenderPage() : const LoginPage());
  }
}
