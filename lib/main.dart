import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseService initialDB = DatabaseService();
  await initialDB.initDB();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TodoX",
      home: HomeScreen(),
    );
  }
}