import 'package:fancale/calender/calender_page.dart';
import 'package:fancale/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) => _builder(context, snapshot));
  }

  Widget _builder(BuildContext context, AsyncSnapshot<User?> snapshot) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: snapshot.connectionState == ConnectionState.waiting
            ? _circular()
            : snapshot.hasData
                ? const CalenderPage()
                : const LoginPage());
  }

  Widget _circular() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
