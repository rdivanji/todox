import 'package:flutter/material.dart';
import 'Todo.dart';

class NewTodoDialog extends StatelessWidget{
  final controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("New Todo"),
      content: TextField(
        controller: controller,
        autofocus: true,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancel"),
          onPressed: (){
            controller.clear();
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Add"),
          onPressed: (){
            final todo = new Todo(date: DateTime.now().millisecondsSinceEpoch , text: controller.value.text, isTodo: true);
            controller.clear();
            Navigator.of(context).pop(todo);
          },
        )
      ],
    );
  }
}