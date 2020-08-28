import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseService initialDB = DatabaseService();
  await initialDB.initDB();

  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String value = _prefs.getString("darkMode") ?? "sys";
  if(value == "sys")
    runApp(MyApp(themeMode: ThemeMode.system));
  else if(value == "on")
    runApp(MyApp(themeMode: ThemeMode.dark));
  else
    runApp(MyApp(themeMode: ThemeMode.light));
}

class MyApp extends StatelessWidget {
  final ThemeMode themeMode;

  const MyApp({@required this.themeMode});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.black,
        ),
      ),
      themeMode: themeMode,
      home: HomeScreen(),
    );
  }
}