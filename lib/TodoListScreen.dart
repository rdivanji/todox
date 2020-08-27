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

  _showToast(Todo todo) {
    final _scaffold = Scaffold.of(context);
    _scaffold.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: const Text('Done!'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: (){
            todo.changeStatus();
            _scaffold.hideCurrentSnackBar();
            /*if the user is still on this screen, then rebuild the widget
            otherwise it will 'naturally' rebuild once user re-enters the screen.
            This is implemented because the SnackBar is still interactive even
            if the user switches views. */
            if(mounted)
              setState(() {});
          },
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index){
    final _todo = _todos[index];

    return ListTile(
      title: Text(_todo.text),
      onTap: () {
        _showToast(_todo);
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