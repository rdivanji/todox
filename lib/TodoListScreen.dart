import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'Todo.dart';

class TodoListScreen extends StatefulWidget {
  TodoListScreen();

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen>{
  DatabaseService _db = DatabaseService();
  List<Todo> _todos;

  _initData() async {
    _todos = await _db.getList(true);
    return _todos;
  }

  _toggleTodo(Todo todo, bool isChecked){
    setState(() {
      todo.isTodo = false;
      _db.updateTodo(todo);
    });
  }

  Widget _buildItem(BuildContext context, int index){
    final _todo = _todos[index];

    return CheckboxListTile(
      value: _todo.isTodo!=true,
      title: Text(_todo.text),
      onChanged: (bool isChecked){
        _toggleTodo(_todo,isChecked);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemBuilder: _buildItem,
              itemCount: _todos.length,
            );
          }
          else
            return Container();
        },
        future: _initData(),
      ),
    );
  }
}