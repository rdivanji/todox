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
      todo.isTodo = !isChecked;
      _db.updateTodo(todo);
    });
  }

  _showToast(Todo todo) {
    final _scaffold = Scaffold.of(context);
    _scaffold.showSnackBar(
      SnackBar(
        content: const Text('Done!'),
        action: SnackBarAction(
          label: 'UNDO',
          //onPressed: _toggleTodo(todo,true),
          onPressed: (){
            _toggleTodo(todo, false);
          },
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index){
    final _todo = _todos[index];

    return CheckboxListTile(
      value: _todo.isTodo!=true, //todo: improve syntax
      title: Text(_todo.text),
      onChanged: (bool isChecked){
        _showToast(_todo);
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