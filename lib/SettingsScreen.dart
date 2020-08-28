import 'package:flutter/material.dart';
import 'DarkModeSettings.dart';

class SettingsScreen extends StatefulWidget{
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>{

  _showDarkModeSettings() async{
    showDialog(
      context: context,
      builder: (BuildContext context){
        return DarkModeSettings();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Settings"),
      children: [
        ListTile(
          leading: Icon(Icons.brightness_4),
          title: Text("Dark Mode"),
          onTap: _showDarkModeSettings,
        ),
      ],
    );
  }

}