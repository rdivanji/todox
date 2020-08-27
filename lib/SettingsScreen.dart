import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget{
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>{

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Settings"),
      children: [
        ListTile(
          leading: Icon(Icons.brightness_4),
          title: Text("Theme"),
          onTap: null,
        ),
        ListTile(
          leading: Icon(Icons.colorize),
          title: Text("Color"),
          onTap: null,
        ),
        ListTile(
          leading: Icon(Icons.view_list),
          title: Text("View"),
          onTap: null,
        )
      ],
    );
  }

}