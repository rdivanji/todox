import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeSettings extends StatefulWidget{
  @override
  _DarkModeSettingsState createState() => _DarkModeSettingsState();
}

class _DarkModeSettingsState extends State<DarkModeSettings>{

  String _value;

  _getPref() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _value = _prefs.getString("darkMode") ?? "sys";
    return _value;
  }

  _updatePref(String value) async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString("darkMode", value);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getPref(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator();
        else {
          return SimpleDialog(
            title: Text("Dark Mode"),
            children: [
              /*'value' represents the value of the button
              'groupValue' is the variable that 'value'
              should match in order for the radio to be
              enabled. So in this case, the sharedPref value
              will enable the proper radio button.
               */
              RadioListTile<String>(
                value: "sys",
                groupValue: _value,
                title: Text("System"),
                onChanged: (String value) {
                  _updatePref(value);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                value: "on",
                groupValue: _value,
                title: Text("On"),
                onChanged: (String value){
                  _updatePref(value);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                value: "off",
                groupValue: _value,
                title: Text("Off"),
                onChanged: (String value){
                  _updatePref(value);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
      }
    );
  }
}