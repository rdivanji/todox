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
    _todos = await _db.getList(1); //get the TodoList
    _todos.sort();
    return _todos;
  }

  _toggleTodo(Todo todo){
    setState(() {
      todo.changeStatus();
    });
  }

  Widget _buildItem(BuildContext context, int index){
    final _todo = _todos[index];

    return ListTile(
      title: Text(_todo.text),
      onTap: () {
        _toggleTodo(_todo);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.separated(
              padding: const EdgeInsets.all(8), //without this, padding of the topmost item is off
              itemBuilder: _buildItem,
              itemCount: _todos.length,
              separatorBuilder: (context, int index) => const Divider(),
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